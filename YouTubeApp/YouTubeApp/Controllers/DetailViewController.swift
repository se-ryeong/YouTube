//
// DetailViewController.swift
// YouTubeApp
//
// Created by SeoJunYoung on 2023/09/04.
//
import UIKit
import YouTubeiOSPlayerHelper

final class DetailViewController: UIViewController {

    let userDataManager = UserDataManager.shared
    private let playerView = YTPlayerView()
    private let titleLabel = UILabel()
    private let viewsLabel = UILabel()
    private let uploadDateLabel = UILabel()
    let dibsOnButton = UIButton()
    let profileImageView = UIImageView()
    let channelNameLabel = UILabel()
    private let commentLabel = UILabel()
    //  private let videoCollectionView = UICollectionView()
    var videoId = "bK6ldnjE3Y0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }
    
    func bind(){

    }
    
    func setUpView() {
        view.backgroundColor = .myBackGroundColor
        setUpPlayerView()
        setUpTitleLabel()
        setUpViewsLabel()
        setUpUploadDateLabel()
        setUpDibsOnButton()
        setUpProfileImageView()
        setUpChannelNameLabel()
        setUpCommentLabel()
        //    setUpVideoCollectionView()
    }
    
    func setUpPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0)
        ])
        let playerVars = ["playsinline": 0]        // https://developers.google.com/youtube/player_parameters?hl=ko : playsinline - 0: 이 값을 지정하면 전체 화면으로 재생됩니다.
        playerView.load(withVideoId: videoId, playerVars: playerVars)
    }
    
    func setUpTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Oppenheimer | Official Trailer"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding), // defaultPadding 값보다 작아도 될 듯
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding)
        ])
    }
    
    func setUpViewsLabel() {
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.text = "조회수 3.5천회"
        viewsLabel.font = viewsLabel.font.withSize(12)
        viewsLabel.textColor = .systemGray6
        view.addSubview(viewsLabel)
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            viewsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
        ])
    }
    
    func setUpUploadDateLabel() {
        uploadDateLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadDateLabel.text = "3일 전"  //or 01 Sep 2023
        uploadDateLabel.font = uploadDateLabel.font.withSize(12)
        uploadDateLabel.textColor = .systemGray6
        view.addSubview(uploadDateLabel)
        NSLayoutConstraint.activate([
            uploadDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            uploadDateLabel.leadingAnchor.constraint(equalTo: viewsLabel.trailingAnchor, constant: 7)
        ])
    }
    
    func setUpDibsOnButton() {
        dibsOnButton.translatesAutoresizingMaskIntoConstraints = false
        dibsOnButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
        dibsOnButton.setTitle(" 찜하기", for: .normal)
        //        dibsOnButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        //        dibsOnButton.setTitle("찜완료", for: .normal)
        
        dibsOnButton.tintColor = .myWhitePointColor
        dibsOnButton.backgroundColor = .darkGray
        dibsOnButton.setTitleColor(.myWhitePointColor, for: .normal)
        dibsOnButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        dibsOnButton.layer.borderWidth = 1
        dibsOnButton.layer.cornerRadius = 15
        dibsOnButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(dibsOnButton)
        NSLayoutConstraint.activate([
            dibsOnButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dibsOnButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
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
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpChannelNameLabel() {
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        channelNameLabel.text = "Universal Pictures"
        channelNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        channelNameLabel.textColor = .white
        view.addSubview(channelNameLabel)
        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 20),
            channelNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
        ])
    }
    
    func setUpCommentLabel() {
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = " 댓글"
        commentLabel.font = UIFont.boldSystemFont(ofSize: 15)
        commentLabel.textColor = .white
        commentLabel.layer.borderColor = UIColor.white.cgColor
        commentLabel.layer.borderWidth = 2
        commentLabel.layer.cornerRadius = 7
        view.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            commentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            commentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            commentLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    //  func setUpVideoCollectionView() {
    //    videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
    //    videoCollectionView.frame = .zero
    //    videoCollectionView.collectionViewLayout = UICollectionViewLayout()
    //    videoCollectionView.backgroundColor = .systemPink
    //
    //    NSLayoutConstraint.activate([
    //      videoCollectionView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 10),
    //      videoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    //      videoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
    //      videoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    //    ])
    //  }
    
    @objc func didTapButton() {
        print("찜하기!")
        if userDataManager.userData[userDataManager.loginId] != nil {
            print(userDataManager.userData[userDataManager.loginId]?.likeList)
            if (userDataManager.userData[userDataManager.loginId]!.likeList.contains(videoId)) {
                if let targetId = userDataManager.userData[userDataManager.loginId]!.likeList.firstIndex(of: videoId) {
                    userDataManager.userData[userDataManager.loginId]!.likeList.remove(at: targetId)
                } else {
                    userDataManager.userData[userDataManager.loginId]!.likeList.append(videoId)
                }
            }
            userDataManager.setData()
            print(userDataManager.userData[userDataManager.loginId]?.likeList)
        }
    }
}

//
//extension DetailViewController: YTPlayerViewDelegate {
//  func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//    playerView.playVideo()       // 자동으로 동영상 실행
//
//  }
//}
