//
//  MyPageView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MyPageView: UIView {
    
    private let videoLabel = UILabel()
    private let logOutButton = UIButton()
    private let nickNameButton = UIButton()
    private let profileButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func setUp(){
        setUpVideoLabel()
        setUplogOutButton()
        setUpnickNameButton()
        setUpprofileButton()
    }
    
    func setUpVideoLabel(){
        videoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(videoLabel)
        videoLabel.text = "관심있는 동영상"
        //        videoLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            videoLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            videoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            videoLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUplogOutButton(){
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logOutButton)
        logOutButton.setTitle("로그아웃", for: .normal)
        logOutButton.setTitleColor(UIColor.black, for: .normal)

        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            logOutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUpnickNameButton(){
        nickNameButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameButton)
        nickNameButton.setTitle("닉네임", for: .normal)
        nickNameButton.setTitleColor(UIColor.black, for: .normal)


        NSLayoutConstraint.activate([
            nickNameButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            nickNameButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUpprofileButton(){
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileButton)
        profileButton.setTitle("프로필 수정", for: .normal)
        profileButton.setTitleColor(UIColor.black, for: .normal)

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            profileButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
}
