//
//  SignInViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInViewController: UIViewController {

    private let signInView = SignInView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - 키보드 대응

    //KeyBoardUp,ViewUp
    @objc func keyboardUp(notification:NSNotification) {
        UIView.animate(withDuration: 0.3, animations: { self.signInView.transform = CGAffineTransform(translationX: 0, y: -50) })
    }
    //KeyBoardDown,ViewDown
    @objc func keyboardDown() {
        self.signInView.transform = .identity
    }
    //배경 터치시 키보드 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}

private extension SignInViewController{
    
    func setUp(){
//        self.view.backgroundColor = UIColor.myBackGroundColor
        self.view.addSubview(signInView)
        signInView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        signInView.signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        signInView.idTextField.delegate = self
        signInView.passWordTextField.delegate = self
    }
    
    // MARK: - ButtonTapped

    @objc func signUpButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func signInButtonTapped(_ sender: UIButton){
        print(#function)
    }
    
}

extension SignInViewController: UITextFieldDelegate{

}
