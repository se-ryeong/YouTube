//
//  SignInView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInView: UIView {

    private let idLabel = UILabel()
    public let idTextField = UITextField()
    private let passWordLabel = UILabel()
    public let passWordTextField = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let stackView = UIStackView()
    
    private let defaultPadding:CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SignInView{
    
    func setUp(){
        self.backgroundColor = .systemBackground
        setUpIdLabel()
        setUpIdTextField()
        setUpPassWordLabel()
        setUpPassWordTextField()
        setUpStackView()
        setUpSignUpButton()
        setUpSignInButton()
    }
    
    func setUpIdLabel(){
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idLabel)
        idLabel.text = "ID"
        idLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            idLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: defaultPadding),
            idLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -defaultPadding),
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
            idTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: defaultPadding),
            idTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -defaultPadding),
            idTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpPassWordLabel(){
        passWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordLabel)
        passWordLabel.text = "PassWord"
        passWordLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            passWordLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 40),
            passWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: defaultPadding),
            passWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -defaultPadding),
        ])
    }
    
    func setUpPassWordTextField(){
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordTextField)
        passWordTextField.placeholder = "아이디를 입력해 주세요."
        passWordTextField.layer.cornerRadius = 8
        passWordTextField.layer.borderWidth = 1
        passWordTextField.addPadding()
        passWordTextField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor),
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: defaultPadding),
            passWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -defaultPadding),
            passWordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor,constant: 50),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: defaultPadding),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -defaultPadding),
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

extension UITextField {
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightViewMode = ViewMode.always
    }
}
