//
//  Tweet.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/25/20.
//

import Foundation

struct Tweet {
    let caption : String
    let tweetId : String
    let uid : String
    let likes : Int
    let retweetCount : Int
    var  timestamp : Date!
    let user : User
    
    init(user: User, tweetId : String, dictionary : [String: Any]) {
        self.tweetId = tweetId
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["like"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp =  Date(timeIntervalSince1970: timestamp)
        }
        
    }
    
}
