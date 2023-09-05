//
//  SignInView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInView: UIView {

    private let logoImageView = UIImageView()
    private let idLabel = UILabel()
    public let idTextField = UITextField()
    private let passWordLabel = UILabel()
    public let passWordTextField = UITextField()
    public let signInButton = UIButton()
    public let signUpButton = UIButton()
    private let stackView = UIStackView()
    private let textFieldHeight:CGFloat = 40

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
        self.frame.size.width = UIScreen.main.bounds.size.width
        self.frame.size.height = UIScreen.main.bounds.size.height
        setUpImageView()
        setUpIdLabel()
        setUpIdTextField()
        setUpPassWordLabel()
        setUpPassWordTextField()
        setUpStackView()
        setUpSignUpButton()
        setUpSignInButton()
    }
    func setUpImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "Logo")
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .defaultPadding * 8),
            logoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding * 2),
            logoImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding * 2),
            logoImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setUpIdLabel(){
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(idLabel)
        idLabel.text = "아이디"
        idLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .defaultPadding),
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .defaultPadding * 2),
            idLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.defaultPadding * 2),
        ])
    }
    
    func setUpIdTextField(){
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idTextField)
        idTextField.placeholder = "아이디를 입력해 주세요."
        idTextField.layer.cornerRadius = 8
        idTextField.layer.borderWidth = 1
        idTextField.addPadding()
        idTextField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor),
            idTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding * 2),
            idTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding * 2),
            idTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }

    func setUpPassWordLabel(){
        passWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordLabel)
        passWordLabel.text = "비밀번호"
        passWordLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            passWordLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: .defaultPadding),
            passWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding * 2),
            passWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding * 2),
        ])
    }

    func setUpPassWordTextField(){
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordTextField)
        passWordTextField.placeholder = "비밀번호를 입력해 주세요."
        passWordTextField.layer.cornerRadius = 8
        passWordTextField.layer.borderWidth = 1
        passWordTextField.addPadding()
        passWordTextField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor),
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding * 2),
            passWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding * 2),
            passWordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }

    func setUpStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor,constant: textFieldHeight),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding * 2),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding * 2),
        ])
    }

    func setUpSignInButton(){
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(signInButton)
        signInButton.setTitle("로그인", for: .normal)
        signInButton.setTitleColor(UIColor.systemGray, for: .normal)
        signInButton.layer.cornerRadius = 8
        signInButton.layer.borderColor = UIColor.systemGray.cgColor
        signInButton.layer.borderWidth = 1

    }

    func setUpSignUpButton(){
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(signUpButton)
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.layer.cornerRadius = 8
        signUpButton.backgroundColor = UIColor.systemGray
    }
}


