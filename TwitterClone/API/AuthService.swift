//
//  AuthService.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/24/20.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email : String
    let password : String
    let userName : String
    let fullName : String
    let profileImage : UIImage
}

struct AuthService {
    static let shared = AuthService ()
    
    func logUserIn(withEmail email : String, password : String, completion : AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials : AuthCredentials, completion : @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.userName
        let fullName = credentials.fullName
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("error is \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    let values = ["email" : email,
                                  "userName" : userName,
                                  "fullName" : fullName,
                                  "profileImageUrl" : profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
