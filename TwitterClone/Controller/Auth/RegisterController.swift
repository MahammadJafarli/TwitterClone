//
//  RegisterController.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/20/20.
//

import UIKit

class RegisterController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    private let photoImageView : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainer : UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainer : UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        return view
    }()
    
    private lazy var fullNameContainer : UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
        return view
    }()
    
    private lazy var userNameContainer : UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: userNameTextField)
        return view
    }()
    
    
    private let emailTextField : UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        return textField
    }()
    
    private let passwordTextField : UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullNameTextField : UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Full name")
        return textField
    }()
    
    private let userNameTextField : UITextField = {
        let textField = Utilities().textField(withPlaceholder: "User name")
        return textField
    }()
    
    private let sigupButtom : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSigup), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccoutButton : UIButton = {
        let button = Utilities().attributeButton("Already have an account? ", "Log in ")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside )
        return button
    }()
    
    override func viewDidLoad() {
        configureUI()
    }
    
    @objc func handleSigup() {
        
    }
    
    @objc func handleProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(photoImageView)
        photoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        photoImageView.setDimensions(width: 125, height: 125)
        
        let stack = UIStackView(arrangedSubviews: [emailContainer, passwordContainer, fullNameContainer, userNameContainer, sigupButtom ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccoutButton)
        alreadyHaveAccoutButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}

extension RegisterController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self .photoImageView.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        photoImageView.layer.cornerRadius = 125 / 2
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.borderWidth = 3
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.imageView?.contentMode = .scaleAspectFit
        photoImageView.imageView?.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
}
