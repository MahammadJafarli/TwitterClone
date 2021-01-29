//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/27/20.
//

import UIKit

struct TweetViewModel {
    let tweet : Tweet
    let user : User
    var profileImageUrl : URL? {
        return user.profileImageUrl
    }
    
    var timeStamp : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var userNameText: String {
        return "@\(user.userName)"
    }
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.likes, text: "Likes")
    }
    
    var userInfoText : NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.userName)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        title.append(NSAttributedString(string: " \(timeStamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: "\(text)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
    
    func size(forWidt widt: CGFloat) -> CGSize {
        let measurementlabel = UILabel()
        measurementlabel.text = tweet.caption
        measurementlabel.numberOfLines = 0
        measurementlabel.lineBreakMode = .byWordWrapping
        measurementlabel.translatesAutoresizingMaskIntoConstraints = false
        measurementlabel.widthAnchor.constraint(equalToConstant: widt).isActive = true
        return measurementlabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
