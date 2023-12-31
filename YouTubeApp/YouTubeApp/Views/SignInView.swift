//
//  SignInView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInView: UIView {
    
    private let loginLabel = UILabel()
    public let idTextField = UITextField()
    private let passWordLabel = UILabel()
    public let passWordTextField = UITextField()
    public let signInButton = UIButton()
    public let signUpButton = UIButton()
    private let signUpInfoLabel = UILabel()
    private let cellHeight:CGFloat = 60
    public let autoLoginButton = UIButton()
    private let userDataManager = UserDataManager.shared
    private let logoImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SignInView{
    
    // MARK: - SetUp
    
    func setUp(){
        //movielogo
        self.frame.size.width = UIScreen.main.bounds.size.width
        self.frame.size.height = UIScreen.main.bounds.size.height
        self.backgroundColor = .myBackGroundColor
        setUpLogoImage()
        setUpLoginLabel()
        setUpIdTextField()
        setUpPassWordTextField()
        setUpSignInButton()
        setUpAutoLoginButton()
        setUpSignUpInfoLabel()
        setUpSignUpButton()
    }
    
    func setUpLogoImage(){
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImage)
        logoImage.image = UIImage(named: "movielo")
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .defaultPadding),
            
        ])
    }
    
    func setUpLoginLabel(){
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
        loginLabel.text = "로그인"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 40)
        loginLabel.textColor = .myWhitePointColor
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: .defaultPadding),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .defaultPadding),
            loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpIdTextField(){
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idTextField)
        idTextField.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [.foregroundColor: UIColor.systemGray])
        idTextField.layer.cornerRadius = 4
        idTextField.backgroundColor = .darkGray
        idTextField.textColor = UIColor.systemGray2
        idTextField.addPadding()
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            idTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            idTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            idTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }

    func setUpPassWordTextField(){
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordTextField)
        passWordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.systemGray])
        passWordTextField.layer.cornerRadius = 4
        passWordTextField.backgroundColor = .darkGray
        passWordTextField.textColor = UIColor.systemGray2
        passWordTextField.isSecureTextEntry = true
        passWordTextField.addPadding()
        NSLayoutConstraint.activate([
            passWordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor,constant: .defaultPadding * 2),
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            passWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            passWordTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    
    func setUpSignInButton(){
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signInButton)
        signInButton.setTitle("로그인", for: .normal)
        signInButton.setTitleColor(.myWhitePointColor, for: .normal)
        signInButton.backgroundColor = .myRedPointColor
        signInButton.layer.cornerRadius = 4
        signInButton.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: .defaultPadding * 3),
            signInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            signInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            signInButton.heightAnchor.constraint(equalToConstant: cellHeight)
        ])

    }
    
    func setUpAutoLoginButton(){
        autoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(autoLoginButton)
        let intervalSpacing = 6.0
        let halfIntervalSpacing = intervalSpacing / 2
        autoLoginButton.contentEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        autoLoginButton.imageEdgeInsets = .init(top: 0, left: -halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        autoLoginButton.titleEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: -halfIntervalSpacing)
        autoLoginButton.setTitle("자동 로그인", for: .normal)
        autoLoginButton.setTitleColor(UIColor.systemGray2, for: .normal)
        
        if userDataManager.autoLogin{
            autoLoginButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            autoLoginButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }
        autoLoginButton.tintColor = .systemGray2
        NSLayoutConstraint.activate([
            autoLoginButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            autoLoginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: .defaultPadding / 2)
        ])
    }
    
    func setUpSignUpInfoLabel(){
        signUpInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpInfoLabel)
        signUpInfoLabel.text = "Movie App 회원이 아닌가요?"
        signUpInfoLabel.textColor = .systemGray
        NSLayoutConstraint.activate([
            signUpInfoLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: .defaultPadding * 3),
            signUpInfoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
        ])
    }
    
    func setUpSignUpButton(){
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpButton)
        signUpButton.setTitle("지금 가입하세요.", for: .normal)
        signUpButton.setTitleColor(.myWhitePointColor, for: .normal)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: signUpInfoLabel.trailingAnchor, constant: .defaultPadding / 2),
            signUpButton.centerYAnchor.constraint(equalTo: signUpInfoLabel.centerYAnchor)
        ])
    }
}


