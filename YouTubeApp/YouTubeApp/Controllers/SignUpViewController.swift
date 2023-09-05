//
//  SignUpViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    
    private var nowTextField = 0

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

        UIView.animate(withDuration: 0.3, animations: { self.signUpView.transform = CGAffineTransform(
            translationX: 0, y: -((.defaultPadding * 2) + 40 + 17) * CGFloat(self.nowTextField)
        )})
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
        signUpView.nickNameTextField.delegate = self
        signUpView.idTextField.delegate = self
        signUpView.passWordTextField.delegate = self
        signUpView.checkPassWordTextField.delegate = self
    }
}

extension SignUpViewController: UITextFieldDelegate{
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
