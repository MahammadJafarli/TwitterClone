//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/27/20.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismissAll()
    func handleEditProfileFollow(_ header: ProfileHeader)
    func didSelect(filter: ProfileFilterOptions)
}

class ProfileHeader: UICollectionReusableView {

    var user: User? {
        didSet{ configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let filterBar = ProfileFilterView()
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 42,
                          paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        return view
    }()
    
    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissAll), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.cornerRadius = 80/2
        return imageView
    }()
    
    lazy var editFollowButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 36/2
        button.addTarget(self, action: #selector(handleEditFollowProfile), for: .touchUpInside)
        return button
    }()
    
    private let fullName : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let userName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."
        return label
    }()
    
    private let followingLabel : UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handlerFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    private let followersLabel : UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handlerFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterBar.delegate = self
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor,
                                left: leftAnchor,
                                paddingTop: -35,
                                paddingLeft: 8,
                                width: 80,
                                height: 80)
        addSubview(editFollowButton)
        editFollowButton.anchor(top: containerView.bottomAnchor,
                                right: rightAnchor,
                                paddingTop: 12,
                                paddingRight: 12,
                                width: 100,
                                height: 35)
        let userDetailStack = UIStackView(arrangedSubviews: [fullName, userName, bioLabel])
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        addSubview(userDetailStack)
        userDetailStack.anchor(top: profileImageView.bottomAnchor,
                               left: leftAnchor,
                               right: rightAnchor,
                               paddingTop: 8,
                               paddingLeft: 12,
                               paddingRight: 12)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 3
        followStack.distribution = .fillEqually
        addSubview(followStack)
        followStack.anchor(top: userDetailStack.bottomAnchor,
                           left: leftAnchor,
                           right: rightAnchor,
                           paddingTop: 8,
                           paddingLeft: 12)
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         height: 50)
    }
    
    @objc func handleDismissAll() {
        delegate?.handleDismissAll()
    }
    
    @objc func handleEditFollowProfile() {
        delegate?.handleEditProfileFollow(self)
    }
    
    @objc func handlerFollowersTapped() {
        
    }
    
    @objc func handlerFollowingTapped() {
        
    }
    
    func configure() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editFollowButton.setTitle(viewModel.actionButtonTitile, for: .normal)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        
        fullName.text = user.fullName
        userName.text = viewModel.userNameText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect index: Int) {
        guard let filter = ProfileFilterOptions(rawValue: index) else { return }
        delegate?.didSelect(filter: filter)
    }
}
