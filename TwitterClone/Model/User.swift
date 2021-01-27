//
//  User.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/24/20.
//

import Foundation
import Firebase

struct User {
    let fullName : String
    let userName : String
    let email : String
    var profileImageUrl : URL?
    let uid : String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var currentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid : String, dictionary: [String : AnyObject]) {
        self.uid = uid
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
