//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 12/1/20.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets & Replies"
        case .likes:
            return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    private let user: User
    
    let userNameText: String
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 0, text: "Followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 2, text: "Following")
    }
    
    var actionButtonTitile: String {
        if user.currentUser {
            return "Edit profile"
        } else {
            return "Follow"
        }
    }
    
    init(user: User) {
        self.user = user
        self.userNameText = "@" + user.userName
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
