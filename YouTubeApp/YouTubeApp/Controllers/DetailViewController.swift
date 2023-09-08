//
// DetailViewController.swift
// YouTubeApp
//
// Created by SeoJunYoung on 2023/09/04.
//

// 이미지랑 찜하기랑 띄우기 //

import UIKit
import YouTubeiOSPlayerHelper

final class DetailViewController: UIViewController {

    let userDataManager = UserDataManager.shared
    
    private let playerView = YTPlayerView()
    private let titleLabel = UILabel()
    private let viewsLabel = UILabel()
    private let uploadDateLabel = UILabel()
    private let dibsOnButton = UIButton()
    let profileImageView = UIImageView()
    private let channelNameLabel = UILabel()
    private let commentLabel = UILabel()
    private let relatedVideoLabel = UILabel()
    private let videoCollectionView = UIImageView()
    
    var videoId: String = ""
    var publishedDate: String = ""
    var isLiked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func bind(_ item: Item){
        videoId = item.id.videoID
        titleLabel.text = item.snippet.title
        channelNameLabel.text = item.snippet.channelTitle
        publishedDate = item.snippet.publishedAt
    }
    
    func setUpView() {
        view.backgroundColor = .myBackGroundColor
        navigationController?.navigationBar.tintColor = .myWhitePointColor
        setUpPlayerView()
        setUpTitleLabel()
        setUpViewsLabel()
        setUpUploadDateLabel()
        setUpDibsOnButton()
        setUpProfileImageView()
        setUpChannelNameLabel()
        setUpRelatedVideoLabel()
        //setUpCommentLabel()
        setUpVideoCollectionView()
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
        //titleLabel.text = videoTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .myWhitePointColor
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding), // defaultPadding 값보다 작아도 될 듯
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding)
        ])
    }
    
    func setUpViewsLabel() {
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.text = "조회수 3천회"
        viewsLabel.font = viewsLabel.font.withSize(12)
        viewsLabel.textColor = .systemGray6
        view.addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            viewsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding)
        ])
    }
    
    func setUpUploadDateLabel() {
        uploadDateLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadDateLabel.text = calculateTimeAgo(from: publishedDate)  //"3일 전"  //or 01 Sep 2023
        uploadDateLabel.font = uploadDateLabel.font.withSize(12)
        uploadDateLabel.textColor = .systemGray6
        view.addSubview(uploadDateLabel)
        
        NSLayoutConstraint.activate([
            uploadDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            uploadDateLabel.leadingAnchor.constraint(equalTo: viewsLabel.trailingAnchor, constant: 7)
        ])
    }
    
//    func changeDataFormat() -> String {
//        let dateFormatter = DateFormatter()
//        let convertDate = dateFormatter.date(from: publishedDate)
//        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
//        let publishedDate = dateFormatter.string(from: convertDate ?? Date())
//        return publishedDate
//    }
    
    func calculateTimeAgo(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        let currentTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date, to: currentTime)
        
        if let years = components.year, years > 0 {
            return "\(years)전"
        } else if let months = components.month, months > 0 {
            return "\(months)달 전"
        } else if let days = components.day, days > 0 {
            return "\(days)일 전"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)시간 전"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)분 전"
        } else {
            return "방금 전"
        }
    }
    //유틸리티 객체..?
    
    func setUpDibsOnButton() {
        dibsOnButton.translatesAutoresizingMaskIntoConstraints = false
        
//        let myId = userDataManager.loginId
//        if userDataManager.userData[myId] != nil {
//            if userDataManager.userData[myId]!.likeList.contains(videoId){
//                dibsOnButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//                dibsOnButton.setTitle("찜완료", for: .normal)
//                dibsOnButton.backgroundColor = .myRedPointColor
//
//            } else {
//                dibsOnButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
//                dibsOnButton.setTitle("찜하기", for: .normal)
//                dibsOnButton.backgroundColor = .darkGray
//            }
//        }
        
        dibsOnButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 13)
        dibsOnButton.tintColor = .myWhitePointColor
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
        //channelNameLabel.text = channelName
        channelNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        channelNameLabel.textColor = .white
        view.addSubview(channelNameLabel)

        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 20),
            channelNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
        ])
    }
    
    
    func setUpRelatedVideoLabel() {
        relatedVideoLabel.translatesAutoresizingMaskIntoConstraints = false
        relatedVideoLabel.text = "이 영상과 비슷한 콘텐츠"
        relatedVideoLabel.font = UIFont.boldSystemFont(ofSize: 18)
        relatedVideoLabel.textColor = .myWhitePointColor
        view.addSubview(relatedVideoLabel)
        
        NSLayoutConstraint.activate([
            relatedVideoLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            relatedVideoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
        ])
    }
    
    func setUpVideoCollectionView() {
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //videoCollectionView.collectionViewLayout = UICollectionViewLayout()
        videoCollectionView.layer.borderColor = UIColor.myRedPointColor.cgColor
        videoCollectionView.layer.borderWidth = 1
        view.addSubview(videoCollectionView)
        
        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: relatedVideoLabel.bottomAnchor, constant: 10),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            videoCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func didTapButton() {
        print("찜하기!")
        
//        let myId = userDataManager.loginId
//        if userDataManager.userData[myId] != nil {
//            if userDataManager.userData[myId]!.likeList.contains(videoId){
//                if let targetIndex = userDataManager.userData[myId]!.likeList.firstIndex(of: videoId){
//                    userDataManager.userData[myId]!.likeList.remove(at: targetIndex)
//                    dibsOnButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
//                    dibsOnButton.setTitle("찜하기", for: .normal)
//                    dibsOnButton.backgroundColor = .darkGray
//                }
//            } else {
//                userDataManager.userData[myId]!.likeList.append(videoId)
//                dibsOnButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//                dibsOnButton.setTitle("찜완료", for: .normal)
//                dibsOnButton.backgroundColor = .myRedPointColor
//            }
//        }
//        userDataManager.setData()
//        print(userDataManager.userData[myId]!.likeList)
    }
}


//
//extension DetailViewController: YTPlayerViewDelegate {
//  func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//    playerView.playVideo()       // 자동으로 동영상 실행
//
//  }
//}
