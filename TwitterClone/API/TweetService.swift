//
//  TweetService.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/24/20.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    func uploadTweet(caption : String, type: UploadTweetCongiguration,completion: @escaping(Error?,DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["uid" : uid,
                      "timestamp" : Int(NSDate().timeIntervalSince1970),
                      "like" : 0,
                      "retweets" : 0,
                      "caption" : caption] as [String : Any]
        
        switch type {
        case .tweet:
            REF_TWEETS.childByAutoId().updateChildValues(values){ (err, ref) in
                guard let tweetId = ref.key else { return }
                REF_USER_TWEETS.child(uid).updateChildValues([tweetId: 1], withCompletionBlock: completion)
            }
        case .reply(let tweet):
            REF_TWEET_REPLIES.child(tweet.tweetId).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void ) {
        var tweets = [Tweet]()
        REF_TWEETS.observe(.childAdded) { snapshot in
            let tweetId = snapshot.key
            guard let dictionary =  snapshot.value as? [String: Any]  else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweets(forUser user: User, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetId = snapshot.key
            REF_TWEETS.child(tweetId).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary =  snapshot.value as? [String: Any]  else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                UserService.shared.fetchUser(uid: uid) { (user) in
                    let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
    
    func fetchReplies(forTweet tweet: Tweet, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        REF_TWEET_REPLIES.child(tweet.tweetId).observe(.childAdded) { snapshot in
            guard let dictionary =  snapshot.value as? [String: Any]  else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetId = snapshot.key
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
