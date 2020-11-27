//
//  RegisterController.swift
//  TwitterClone
//
//  Created by Mahammad Jafarli on 11/20/20.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    private var profileImage : UIImage?
    
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
        guard let profileImage = profileImage else {
            makeAlert(titleInput: "Error", messageInput: "DEBUG: Please select a profile Image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let userName = userNameTextField.text?.lowercased() else { return }
        guard let fullName = fullNameTextField.text else { return }
        
        if email != "" && password != "" && userName != "" && fullName != "" {
            let credentials = AuthCredentials(email: email, password: password, userName: userName, fullName: fullName, profileImage: profileImage)
            AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                guard let tab = window.rootViewController as? MainTabController else { return }
                tab.authenicateUserAndConfigureUI()
                self.dismiss(animated: true, completion: nil)
            }
        } else{
            makeAlert(titleInput: "Error", messageInput: "DEBUG: Please enter all values")
        }
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
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension RegisterController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.profileImage = profileImage
        
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
