/*import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - Register User
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else { return }
            
            self.db.collection("users").document(user.uid).setData([
                "email": email,
                "createdAt": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    // MARK: - Login User
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    // MARK: - Logout User
    func logoutUser() {
        do {
            try auth.signOut()
            print("✅ Logged out")
        } catch {
            print("❌ Error logging out: \(error.localizedDescription)")
        }
    }
 }*/
