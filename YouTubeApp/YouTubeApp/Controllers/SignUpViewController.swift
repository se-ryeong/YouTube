//
//  SignUpViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(signUpView)
    }

}
