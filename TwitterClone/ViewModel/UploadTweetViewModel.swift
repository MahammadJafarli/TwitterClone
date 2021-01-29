//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 1/29/21.
//

import UIKit

enum UploadTweetCongiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
    
    init(config: UploadTweetCongiguration) {
        switch config {
            case .tweet:
                actionButtonTitle = "Tweet"
                placeholderText = "What's happening"
                shouldShowReplyLabel = false
            case .reply(let tweet):
                actionButtonTitle = "Reply"
                placeholderText = "Tweet you reply"
                shouldShowReplyLabel = true
                replyText = "Replying to @\(tweet.user.userName)"
        }
    }
    
}
