//
//  SignInViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInViewController: UIViewController {

    private let signInView = SignInView()
    private let userDataManager = UserDataManager.shared
    
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
        UIView.animate(withDuration: 0.3, animations: { self.signInView.transform = CGAffineTransform(translationX: 0, y: -60) })
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
        userDataManager.loadData()
        if userDataManager.autoLogin{
            print(userDataManager.autoLogin)
            if userDataManager.loginId != ""{
                let tabbar = TabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabbar, animated: true)
                print("자동 LogIn 성공")
            }
        }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .myBackGroundColor
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance
        
        self.view.addSubview(signInView)
        signInView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        signInView.signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        signInView.autoLoginButton.addTarget(self, action: #selector(autoLoginButtonTapped(_:)), for: .touchUpInside)
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
        self.view.endEditing(true)
        tryLogin()
    }
    @objc func autoLoginButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        userDataManager.autoLogin.toggle()
        if userDataManager.autoLogin{
            signInView.autoLoginButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            signInView.autoLoginButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }
    }
    private func tryLogin() -> Void{
        guard let id = signInView.idTextField.text,
              let passWord = signInView.passWordTextField.text else { return }
        var state = ""
        var content = ""
        if id.count == 0{
            state = "로그인 실패"
            content = "아이디를 입력해주세요"
        } else if passWord.count == 0{
            state = "로그인 실패"
            content = "비밀번호를 입력해주세요."
        } else {
            if userDataManager.userData[id] == nil{
                state = "로그인 실패"
                content = "등록되지 않은 아이디 입니다"
            } else {
                if userDataManager.userData[id]?.passWord == passWord{
                    userDataManager.loginId = id
                    userDataManager.setData()
                    let tabbar = TabBarController()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabbar, animated: false)
                    print("LogIn 성공")
                    return
                } else {
                    state = "로그인 실패"
                    content = "비밀번호를 확인해 주세요."
                }
            }
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in }
        let alert = UIAlertController(title: state, message: content, preferredStyle: .alert)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SignInViewController: UITextFieldDelegate{

}
