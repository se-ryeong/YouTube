//
//  MyPageView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MyPageView: UICollectionViewCell {
    
    private let videoLabel = UILabel()
    private let logOutButton = UIButton()
    private let nickNameButton = UIButton()
    private let profileButton = UIButton()
    private let profileImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
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
        setUpProfileImageView()
        
    }
    
    func setUpVideoLabel(){
        videoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(videoLabel)
        videoLabel.text = "관심있는 동영상"
        videoLabel.textColor = .white
        //        videoLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        NSLayoutConstraint.activate([
            videoLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 250),
            videoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            videoLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUplogOutButton(){
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logOutButton)
        logOutButton.setTitle("로그아웃", for: .normal)
        logOutButton.setTitleColor(UIColor.white, for: .normal)

        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            logOutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUpnickNameButton(){
        nickNameButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nickNameButton)
        nickNameButton.setTitle("닉네임", for: .normal)
        nickNameButton.setTitleColor(UIColor.white, for: .normal)


        NSLayoutConstraint.activate([
            nickNameButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 70),
            nickNameButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            nickNameButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUpprofileButton(){
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileButton)
        profileButton.setTitle("프로필 수정", for: .normal)
        profileButton.setTitleColor(UIColor.white, for: .normal)

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
            profileButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            profileButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    func setUpProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.backgroundColor = .systemIndigo
        profileImageView.tintColor = .white
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            //topAnchor 위에 기준
            //bottomAnchor 아래 기준
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
