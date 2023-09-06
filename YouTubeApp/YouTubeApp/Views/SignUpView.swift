//
//  SignUpView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignUpView: UIView {

    private let signUpLabel = UILabel()
    public let nickNameLabel = UILabel()
    public let nickNameTextField = UITextField()
    public let idLabel = UILabel()
    public let idTextField = UITextField()
    public let passWordLabel = UILabel()
    public let passWordTextField = UITextField()
    public let checkPassWordLabel = UILabel()
    public let checkPassWordTextField = UITextField()
    public let signUpButton = UIButton()
    private let cellHeight:CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension SignUpView{
    
    func setUp(){
        self.backgroundColor = .myBackGroundColor
        self.frame.size.width = UIScreen.main.bounds.size.width
        self.frame.size.height = UIScreen.main.bounds.size.height
        setUpSignUpLabel()
        
        setUpNickNameTextField()
        setUpNickNameLabel()
        
        setUpIdTextField()
        setUpIdLabel()
        
        setUpPassWordTextField()
        setUpPassWordLabel()
        
        setUpCheckPassWordTextField()
        setUpCheckPassWordLabel()
        
        setUpSignUpButton()
    }
    
    func setUpSignUpLabel(){
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpLabel)
        signUpLabel.text = "회원가입"
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 40)
        signUpLabel.textColor = .myWhitePointColor
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            signUpLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            signUpLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpNickNameTextField(){
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameTextField)
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.systemGray])
        nickNameTextField.layer.cornerRadius = 4
        nickNameTextField.backgroundColor = .darkGray
        nickNameTextField.textColor = UIColor.systemGray2
        nickNameTextField.addPadding()
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: .defaultPadding),
            nickNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            nickNameTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    func setUpNickNameLabel(){
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameLabel)
        nickNameLabel.isHidden = true
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            nickNameLabel.topAnchor.constraint(equalTo: self.nickNameTextField.bottomAnchor),
            nickNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
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
            idTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: .defaultPadding * 2),
            idTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            idTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            idTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    
    func setUpIdLabel(){
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idLabel)
        idLabel.isHidden = true
        idLabel.text = "8글자 이상의 아이디를 입력해주세요"
        idLabel.font = UIFont.systemFont(ofSize: 15)
        idLabel.textColor = .myRedPointColor
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor),
            idLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            idLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
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
            passWordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: .defaultPadding * 2),
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            passWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            passWordTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    
    func setUpPassWordLabel(){
        passWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordLabel)
        passWordLabel.isHidden = true
        passWordLabel.text = "8글자 이상의 비밀번호를 입력해주세요"
        passWordLabel.font = UIFont.systemFont(ofSize: 15)
        passWordLabel.textColor = .myRedPointColor
        NSLayoutConstraint.activate([
            passWordLabel.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor),
            passWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            passWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpCheckPassWordTextField(){
        checkPassWordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkPassWordTextField)
        checkPassWordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [.foregroundColor: UIColor.systemGray])
        checkPassWordTextField.layer.cornerRadius = 4
        checkPassWordTextField.backgroundColor = .darkGray
        checkPassWordTextField.textColor = UIColor.systemGray2
        checkPassWordTextField.isSecureTextEntry = true
        checkPassWordTextField.addPadding()
        NSLayoutConstraint.activate([
            checkPassWordTextField.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: .defaultPadding * 2),
            checkPassWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            checkPassWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            checkPassWordTextField.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    
    func setUpCheckPassWordLabel(){
        checkPassWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkPassWordLabel)
        checkPassWordLabel.isHidden = true
        checkPassWordLabel.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            checkPassWordLabel.topAnchor.constraint(equalTo: checkPassWordTextField.bottomAnchor),
            checkPassWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            checkPassWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpSignUpButton(){
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpButton)
        signUpButton.isHidden = true
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.backgroundColor = .myRedPointColor
        signUpButton.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: checkPassWordTextField.bottomAnchor, constant: .defaultPadding * 2),
            signUpButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            signUpButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            signUpButton.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
    
}

