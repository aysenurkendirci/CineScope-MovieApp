import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserProfile {
    let uid: String
    let email: String
    let favorites: [Int]?
    var avatarURL: String?        
}

final class UserService {
    static let shared = UserService()
    private init() {}
    
    let db = Firestore.firestore()
    
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserService", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "No user logged in"])))
            return
        }
        
        db.collection("users").document(user.uid).getDocument { snapshot, error in
            if let error = error { completion(.failure(error)); return }
            
            let data = snapshot?.data() ?? [:]
            let email = (data["email"] as? String) ?? user.email ?? "-"
            let favorites = data["favorites"] as? [Int] ?? []
            let avatar = data["avatarURL"] as? String            
            
            let profile = UserProfile(uid: user.uid,
                                      email: email,
                                      favorites: favorites,
                                      avatarURL: avatar)
            completion(.success(profile))
        }
    }
    
    func addFavorite(movieId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserService", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "No user logged in"])))
            return
        }
        db.collection("users").document(user.uid).updateData([
            "favorites": FieldValue.arrayUnion([movieId])
        ]) { error in
            error == nil ? completion(.success(())) : completion(.failure(error!))
        }
    }
    
    func removeFavorite(movieId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserService", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "No user logged in"])))
            return
        }
        db.collection("users").document(user.uid).updateData([
            "favorites": FieldValue.arrayRemove([movieId])
        ]) { error in
            error == nil ? completion(.success(())) : completion(.failure(error!))
        }
    }
    
    func isFavorite(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserService", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "No user logged in"])))
            return
        }
        db.collection("users").document(user.uid).getDocument { snapshot, error in
            if let error = error { completion(.failure(error)); return }
            let data = snapshot?.data() ?? [:]
            let favorites = data["favorites"] as? [Int] ?? []
            completion(.success(favorites.contains(movieId)))
        }
    }
 
    func updateAvatar(urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserService", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "No user logged in"])))
            return
        }
        db.collection("users").document(user.uid).setData(
            ["avatarURL": urlString],
            merge: true
        ) { error in
            error == nil ? completion(.success(())) : completion(.failure(error!))
        }
    }
}
