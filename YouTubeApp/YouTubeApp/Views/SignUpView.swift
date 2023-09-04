//
//  SignUpView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignUpView: UIView {

    private let nickNameLabel = UILabel()
    public let nickNameTextField = UITextField()
    private let idLabel = UILabel()
    public let idTextField = UITextField()
    private let passWordLabel = UILabel()
    public let passWordTextField = UITextField()
    private let checkPassWordLabel = UILabel()
    public let checkPassWordTextField = UITextField()
    
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
        self.backgroundColor = .systemBackground
        setUpNickNameLabel()
        setUpNickNameTextField()
        setUpIdLabel()
        setUpIdTextField()
        setUpPassWordLabel()
        setUpPassWordTextField()
        setUpCheckPassWordLabel()
        setUpCheckPassWordTextField()
    }
    
    func setUpNickNameLabel(){
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameLabel)
        nickNameLabel.text = "닉네임"
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            nickNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            nickNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpNickNameTextField(){
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameTextField)
        nickNameTextField.placeholder = "닉네임을 입력해 주세요."
        nickNameTextField.layer.cornerRadius = 8
        nickNameTextField.layer.borderWidth = 1
        nickNameTextField.addPadding()
        nickNameTextField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor),
            nickNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpIdLabel(){
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(idLabel)
        idLabel.text = "아이디"
        idLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: .defaultPadding),
            idLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            idLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
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
            idTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            idTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            idTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpPassWordLabel(){
        passWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passWordLabel)
        passWordLabel.text = "비밀번호"
        passWordLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            passWordLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: .defaultPadding),
            passWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            passWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
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
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            passWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            passWordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpCheckPassWordLabel(){
        checkPassWordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkPassWordLabel)
        checkPassWordLabel.text = "비밀번호 확인"
        checkPassWordLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            checkPassWordLabel.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: .defaultPadding),
            checkPassWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            checkPassWordLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpCheckPassWordTextField(){
        checkPassWordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkPassWordTextField)
        checkPassWordTextField.placeholder = "비밀번호를 입력해 주세요."
        checkPassWordTextField.layer.cornerRadius = 8
        checkPassWordTextField.layer.borderWidth = 1
        checkPassWordTextField.addPadding()
        checkPassWordTextField.layer.borderColor = UIColor.systemGray.cgColor
        NSLayoutConstraint.activate([
            checkPassWordTextField.topAnchor.constraint(equalTo: checkPassWordLabel.bottomAnchor),
            checkPassWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            checkPassWordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            checkPassWordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
}
