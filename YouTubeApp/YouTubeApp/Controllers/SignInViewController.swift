//
//  SignInViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignInViewController: UIViewController {

    private let signInView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    

}

extension SignInViewController{
    
    private func setUp(){
        self.view.addSubview(signInView)
        signInView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
    }
    // MARK: - ButtonTapped

    @objc func signUpButtonTapped(_ sender: UIButton){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
