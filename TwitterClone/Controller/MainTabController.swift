//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/20/20.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureViewController()
    }
    
    func configureViewController() {
        let feed = FeedConteoller()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(named: "like_unselected")
        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(named: "mail")

        
        viewControllers = [feed, explore, notifications, conversations]
    }

}
 
