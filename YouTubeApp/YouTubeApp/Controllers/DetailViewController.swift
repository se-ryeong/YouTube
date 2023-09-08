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
    
    var videoSnippet: [VideoItem] = []
    var categoryItems: [Item] = []
    var videoStatistics: [StatisticsItem] = []
    private let playerView = YTPlayerView()
    private let titleLabel = UILabel()
    private let viewCountLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let dibsOnButton = UIButton()
    let profileImageView = UIImageView()
    private let channelNameLabel = UILabel()
    private let relatedVideoLabel = UILabel()
    
    var videoId: String = ""
    var publishedDate: String = "바보"
    var viewCount: String = "똥개"
    var categoryId: String = "1"
    
    private let videoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    // UICollectionView must be initialized with a non-nil layout parameter > nil이 아닌 layout 파라미터로 초기화 해줘야댐 무조건
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(publishedDate)
        print(viewCount)
        getData()
        setUpView()
        print(publishedDate)
        print(viewCount)
        print("\(categoryItems.count)")
    }
    
    func bind(_ item: Item){
        videoId = item.id.videoID
    }
    
    func getData() {
        VideoURLService().getVideoInfo(videoId) { [weak self] items in
            //print(items)
            guard let self else { return }
            self.videoSnippet = items
            
            DispatchQueue.main.async {
                self.titleLabel.text = self.videoSnippet.first?.snippet.title
                self.channelNameLabel.text = self.videoSnippet.first?.snippet.channelTitle
                self.publishedDate = self.videoSnippet.first?.snippet.publishedAt ?? ""
                //self.categoryId = self.videoSnippet.first?.snippet.categoryId ?? ""
                // publishedAt을 옵셔널로 선언해주지 않았더라도 first? > 라고 해주는 순간 publishedAt도 옵셔널값이 될 수 있으므로 ?? "" 필요함
            }
        }
        // 동작하는 스레드가 다름. API 호출하는건 비동기 스레드/ UI 업데이트는 Main 스레드에서 동작되어야 함. > 따로따로 해줘야함. 한 공간에서 하면 오래 걸림.
        
        VideoURLService().getViewCount(videoId) { [weak self] items in
            
            guard let self else { return }
            self.videoStatistics = items
            
            DispatchQueue.main.async {
                self.viewCount = self.videoStatistics.first?.statistics.viewCount ?? ""
            }
        }
        
        YouTubeService().fetchYouTubeThumbnails(categoryId) { [weak self] items in
            //print(items)
            guard let self else { return }
            self.categoryItems = items
            
            DispatchQueue.main.async {
                self.videoCollectionView.reloadData()
            }
        }
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
        setUpVideoCollectionView()
    }
    
    func setUpPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0)
        ])
        let playerVars = ["playsinline": 0]        // https://developers.google.com/youtube/player_parameters?hl=ko : playsinline - 0: 이 값을 지정하면 전체 화면으로 재생됩니다.
        playerView.load(withVideoId: videoId, playerVars: playerVars)
    }
    
    func setUpTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .myWhitePointColor
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding)
        ])
    }
    
    func setUpViewsLabel() {
        viewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewCountLabel.text = "조회수 \(viewCount)회"
        viewCountLabel.font = viewCountLabel.font.withSize(12)
        viewCountLabel.textColor = .systemGray6
        view.addSubview(viewCountLabel)
        
        NSLayoutConstraint.activate([
            viewCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            viewCountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding)
        ])
    }
    
    func setUpUploadDateLabel() {
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.text = calculateTimeAgo(from: publishedDate)
        publishedDateLabel.font = publishedDateLabel.font.withSize(12)
        publishedDateLabel.textColor = .systemGray6
        view.addSubview(publishedDateLabel)
        
        NSLayoutConstraint.activate([
            publishedDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            publishedDateLabel.leadingAnchor.constraint(equalTo: viewCountLabel.trailingAnchor, constant: 7)
        ])
    }
    
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
            dibsOnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
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
            profileImageView.topAnchor.constraint(equalTo: viewCountLabel.bottomAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpChannelNameLabel() {
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        channelNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        channelNameLabel.textColor = .white
        view.addSubview(channelNameLabel)
        
        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: viewCountLabel.bottomAnchor, constant: 20),
            channelNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
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
            relatedVideoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding)
        ])
    }
    
    func setUpVideoCollectionView() {
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        videoCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)

        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        videoCollectionView.backgroundColor = .myBackGroundColor
        view.addSubview(videoCollectionView)

        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: relatedVideoLabel.bottomAnchor, constant: 10),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
            videoCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func didTapButton() {
        print("찜하기!")
        
        //        let myId = userDataManager.loginId
        //        if userDataManager.userData[myId] != nil {
        //            if userDataManager.userData[myId]!.likeList.(categoryItems[videoId])){
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

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        cell.configureCell(item: categoryItems[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        //vc.bind(categoryItems[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - (.defaultPadding * 2) - 10) / 3.5
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

}
