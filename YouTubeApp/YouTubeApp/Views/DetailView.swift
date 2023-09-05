//
//  DetailView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class DetailView: UIView {
    
    private let playImageView = UIImageView()
    private let titleLabel = UILabel()
    private let viewsLabel = UILabel()
    private let uploadDateLabel = UILabel()
    private let dibsOnButton = UIButton()
    let profileImageView = UIImageView()
    let channelNameLabel = UILabel()
    private let commentLabel = UILabel()
//    private let videoCollectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension DetailView {
    
    func setUpView() {
        setUpPlayImageView()
        setUpTitleLabel()
        setUpViewsLabel()
        setUpUploadDateLabel()
        setUpDibsOnButton()
        setUpProfileImageView()
        setUpChannelNameLabel()
        setUpCommentLabel()
//        setUpVideoCollectionView()
    }
    
    func setUpPlayImageView() {
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.image = UIImage(systemName: "play.rectangle")
        playImageView.tintColor = .red
        playImageView.contentMode = .scaleAspectFit
        playImageView.layer.borderColor = UIColor.lightGray.cgColor
        playImageView.layer.borderWidth = 2
        addSubview(playImageView)
        
        NSLayoutConstraint.activate([
            playImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            playImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            playImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            playImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func setUpTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "동영상 제목입니당 다크모드가 예쁠 것 같아"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: playImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),  // defaultPadding 값보다 작아도 될 듯
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding)
        ])
    }
    
    func setUpViewsLabel() {
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.text = "조회수 3.5천회"
        viewsLabel.font = viewsLabel.font.withSize(10)
        viewsLabel.textColor = .darkGray
        addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            viewsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
        ])
    }
    
    func setUpUploadDateLabel() {
        uploadDateLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadDateLabel.text = "3일 전"   //or 01 Sep 2023
        uploadDateLabel.font = uploadDateLabel.font.withSize(10)
        uploadDateLabel.textColor = .darkGray
        addSubview(uploadDateLabel)
        
        NSLayoutConstraint.activate([
            uploadDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            uploadDateLabel.leadingAnchor.constraint(equalTo: viewsLabel.trailingAnchor, constant: 7)
        ])
    }
    
    func setUpDibsOnButton() {
        dibsOnButton.translatesAutoresizingMaskIntoConstraints = false
        dibsOnButton.setImage(UIImage(systemName: "plus.square.on.square"), for: .normal)
        dibsOnButton.tintColor = .black
        dibsOnButton.setTitle(" 찜하기", for: .normal)
        dibsOnButton.setTitleColor(.black, for: .normal)
        dibsOnButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        dibsOnButton.layer.borderColor = UIColor.black.cgColor
        dibsOnButton.layer.borderWidth = 1
        dibsOnButton.layer.cornerRadius = 15
        // dibsOnButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        addSubview(dibsOnButton)
        
        NSLayoutConstraint.activate([
            dibsOnButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dibsOnButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            dibsOnButton.widthAnchor.constraint(equalToConstant: 80),
            dibsOnButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.backgroundColor = .systemIndigo
        profileImageView.tintColor = .white
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 15
        profileImageView.clipsToBounds = true
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpChannelNameLabel() {
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        channelNameLabel.text = "채널명입니다"
        channelNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(channelNameLabel)
        
        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 20),
            channelNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
        ])
    }
    
    func setUpCommentLabel() {
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = "  댓글"
        commentLabel.font = UIFont.boldSystemFont(ofSize: 15)
        commentLabel.layer.borderColor = UIColor.black.cgColor
        commentLabel.layer.borderWidth = 2
        commentLabel.layer.cornerRadius = 7
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            commentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            commentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            commentLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
//    func setUpVideoCollectionView() {
//        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        videoCollectionView.frame = .zero
//        videoCollectionView.collectionViewLayout = UICollectionViewLayout()
//        videoCollectionView.backgroundColor = .systemPink
//
//        NSLayoutConstraint.activate([
//            videoCollectionView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 10),
//            videoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            videoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            videoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
//        ])
//    }

}
