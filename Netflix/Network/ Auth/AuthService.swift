import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

final class AuthService {
    
    static let shared = AuthService()
    private init() {}
    private let db = Firestore.firestore()
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        print("Register attempt with email=\(email)")
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Register failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthService",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            print("Register successful: \(user.email ?? "nil") (UID: \(user.uid))")
            
            self.db.collection("users").document(user.uid).setData([
                "email": email,
                "provider": "password",
                "createdAt": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    print("Firestore save failed: \(error.localizedDescription)")
                } else {
                    print("Firestore user document created for \(email)")
                }
            }
            user.reload { _ in
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Login with Email
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        print("Login attempt with email=\(email)")
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthService",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            print("Login successful: \(user.email ?? "nil") (UID: \(user.uid))")
            user.reload { _ in
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Google Sign In
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        print("Google Sign-In attempt")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "AuthService",
                                        code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Missing Client ID"])))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                print("Google sign-in failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "AuthService",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Google sign in failed"])))
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase auth with Google failed: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let firebaseUser = authResult?.user else {
                    completion(.failure(NSError(domain: "AuthService",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Firebase user not found"])))
                    return
                }
                
                print("Google login successful: \(firebaseUser.email ?? "nil") (UID: \(firebaseUser.uid))")
                
                self.db.collection("users").document(firebaseUser.uid).setData([
                    "email": firebaseUser.email ?? "",
                    "provider": "google",
                    "createdAt": Timestamp(date: Date())
                ], merge: true) { error in
                    if let error = error {
                        print("Firestore save failed: \(error.localizedDescription)")
                    } else {
                        print("Firestore user document updated for Google user \(firebaseUser.email ?? "nil")")
                    }
                }
                
                firebaseUser.reload { _ in
                    completion(.success(firebaseUser))
                }
            }
        }
    }
    
    // MARK: - Logout
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            print("Logout successful")
            completion(.success(()))
        } catch {
            print("Logout failed: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    // MARK: - Get Current User
    func getCurrentUser() -> User? {
        let user = Auth.auth().currentUser
        print("Current user: \(user?.email ?? "nil")")
        return user
    }
}
