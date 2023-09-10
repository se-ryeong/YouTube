//
//  SignUpViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    
    private let userDataManager = UserDataManager.shared
    
    private var nowTextField = 0
    
    private var buttonToggle = [false,false,false,false]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - 키보드 대응

    //KeyBoardUp,ViewUp
    @objc func keyboardUp(notification:NSNotification) {
        if nowTextField < 2{
            let yValue = CGFloat((56 + (92 * nowTextField)))
            UIView.animate(withDuration: 0.3, animations: { self.signUpView.transform = CGAffineTransform( translationX: 0, y: -yValue)})
        } else {
            let yValue = CGFloat((56 + (92)))
            UIView.animate(withDuration: 0.3, animations: { self.signUpView.transform = CGAffineTransform( translationX: 0, y: -yValue)})
        }
    }
    //KeyBoardDown,ViewDown
    @objc func keyboardDown() {
        self.signUpView.transform = .identity
    }
    //배경 터치시 키보드 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
private extension SignUpViewController{
    
    func setUp(){
        self.view.addSubview(signUpView)
        navigationController?.navigationBar.tintColor = .myWhitePointColor
        signUpView.nickNameTextField.delegate = self
        signUpView.idTextField.delegate = self
        signUpView.passWordTextField.delegate = self
        signUpView.checkPassWordTextField.delegate = self
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        guard let nickName = signUpView.nickNameTextField.text,
              let id = signUpView.idTextField.text,
              let passWord = signUpView.checkPassWordTextField.text else { return }
        userDataManager.appendUser(nickName: nickName, id: id, passWord: passWord)
        userDataManager.setData()
        let alert = UIAlertController(title: "가입완료", message: "회원가입이 완료되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "로그인 화면으로 이동", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
            }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func buttonHiddenMotion(toggle:Bool){
        UIView.transition(with: signUpView.signUpButton, duration: 0.5, options: .transitionFlipFromTop, animations: { [weak self] in
            if toggle{
                self?.signUpView.signUpButton.alpha = 0
            } else {
                self?.signUpView.signUpButton.alpha = 1
            }
        })
    }
}

extension SignUpViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == signUpView.nickNameTextField{
            if text.count == 0{
                signUpView.nickNameLabel.isHidden = true
                buttonToggle[0] = false
            } else if text.count < 3{
                signUpView.nickNameLabel.isHidden = false
                signUpView.nickNameLabel.text = "3글자 이상의 닉네임을 입력해주세요"
                signUpView.nickNameLabel.textColor = .myRedPointColor
                buttonToggle[0] = false
            } else {
                signUpView.nickNameLabel.isHidden = false
                signUpView.nickNameLabel.text = "사용할 수 있는 닉네임 입니다."
                signUpView.nickNameLabel.textColor = .systemGreen
                buttonToggle[0] = true
            }
        } else if textField == signUpView.idTextField{
            if text.count == 0{
                signUpView.idLabel.isHidden = true
                buttonToggle[1] = false
            } else if text.count < 8{
                signUpView.idLabel.isHidden = false
                signUpView.idLabel.text = "8글자 이상의 아이디를 입력해주세요"
                signUpView.idLabel.textColor = .myRedPointColor
                buttonToggle[1] = false
            } else {
                if userDataManager.userData[text] == nil{
                    signUpView.idLabel.isHidden = false
                    signUpView.idLabel.text = "사용할 수 있는 아이디 입니다."
                    signUpView.idLabel.textColor = .systemGreen
                    buttonToggle[1] = true
                } else {
                    signUpView.idLabel.isHidden = false
                    signUpView.idLabel.text = "이미 가입한 아이디 입니다."
                    signUpView.idLabel.textColor = .myRedPointColor
                    buttonToggle[1] = false
                }
            }
        } else if textField == signUpView.passWordTextField{
            if text.count == 0{
                signUpView.passWordLabel.isHidden = true
                buttonToggle[2] = false
            } else if text.count < 8{
                signUpView.passWordLabel.isHidden = false
                signUpView.passWordLabel.text = "8글자 이상의 비밀번호를 입력해주세요"
                signUpView.passWordLabel.textColor = .myRedPointColor
                buttonToggle[2] = false
            } else {
                signUpView.passWordLabel.isHidden = false
                signUpView.passWordLabel.text = "사용할 수 있는 비밀번호입니다."
                signUpView.passWordLabel.textColor = .systemGreen
                buttonToggle[2] = true
            }
            if text == signUpView.checkPassWordTextField.text!{
                signUpView.checkPassWordLabel.isHidden = false
                signUpView.checkPassWordLabel.text = "비밀번호가 일치합니다."
                signUpView.checkPassWordLabel.textColor = .systemGreen
                buttonToggle[3] = true
            } else {
                signUpView.checkPassWordLabel.isHidden = false
                signUpView.checkPassWordLabel.text = "비밀번호가 일치하지 않습니다"
                signUpView.checkPassWordLabel.textColor = .myRedPointColor
                buttonToggle[3] = false
            }
        } else {
            if text.count == 0{
                signUpView.checkPassWordLabel.isHidden = true
                buttonToggle[3] = false
            } else {
                if text == signUpView.passWordTextField.text!{
                    signUpView.checkPassWordLabel.isHidden = false
                    signUpView.checkPassWordLabel.text = "비밀번호가 일치합니다."
                    signUpView.checkPassWordLabel.textColor = .systemGreen
                    buttonToggle[3] = true
                } else {
                    signUpView.checkPassWordLabel.isHidden = false
                    signUpView.checkPassWordLabel.text = "비밀번호가 일치하지 않습니다"
                    signUpView.checkPassWordLabel.textColor = .myRedPointColor
                    buttonToggle[3] = false
                }
            }
        }
        if buttonToggle[0] && buttonToggle[1] && buttonToggle[2] && buttonToggle[3]{
            if signUpView.signUpButton.isHidden == true{
                signUpView.signUpButton.isHidden = false
                buttonHiddenMotion(toggle: signUpView.signUpButton.isHidden)
            }
        } else {
            signUpView.signUpButton.isHidden = true
            buttonHiddenMotion(toggle: signUpView.signUpButton.isHidden)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == signUpView.nickNameTextField{
            nowTextField = 0
        } else if textField == signUpView.idTextField{
            nowTextField = 1
        } else if textField == signUpView.passWordTextField{
            nowTextField = 2
        } else {
            nowTextField = 3
        }
    }

}
