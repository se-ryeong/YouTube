//
//  MyPageViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let MyPageframe = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return MyPageframe
    }()
    
    private let nickNameLabel = UILabel()
    
    private let likeListLabel = UILabel()
    
    private let logOutButton = UIButton()
    
    private let profilEditButton = UIButton()
    
    private let infoLabel = UILabel()
    
    private let userDataManager = UserDataManager.shared
    
    lazy var myId = userDataManager.loginId
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpCollectionView()
        self.collectionView.reloadData()
    }
}

private extension MyPageViewController{
    
    // MARK: - SetUp

    func setUp(){
        self.view.backgroundColor = .myBackGroundColor
        setUpIdLabel()
        setUpProfileEditButton()
        setUpLogOutButton()
        setUpLikeListLabel()
        setUpCollectionView()

    }

    func setUpIdLabel(){
        view.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        if userDataManager.userData[myId] != nil {
            nickNameLabel.text = "안녕하세요 \(userDataManager.userData[myId]!.nickName) 님" }
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        nickNameLabel.textColor = .white
        NSLayoutConstraint.activate([
            nickNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            nickNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpLogOutButton(){
        logOutButton.setTitle("로그아웃", for: .normal)
        logOutButton.setTitleColor(.myRedPointColor, for: .normal)
        logOutButton.layer.cornerRadius = 4
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped(_:)), for: .touchUpInside)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
    }
    
    func setUpProfileEditButton(){
        view.addSubview(profilEditButton)
        profilEditButton.translatesAutoresizingMaskIntoConstraints = false
        profilEditButton.setTitle("닉네임 수정", for: .normal)
        profilEditButton.backgroundColor = .myGrayPointColor
        profilEditButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        profilEditButton.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            profilEditButton.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: .defaultPadding),
            profilEditButton.leadingAnchor.constraint(equalTo: nickNameLabel.leadingAnchor),
            profilEditButton.trailingAnchor.constraint(equalTo: nickNameLabel.trailingAnchor),
        ])
    }
    
    func setUpLikeListLabel(){
        view.addSubview(likeListLabel)
        likeListLabel.translatesAutoresizingMaskIntoConstraints = false
        likeListLabel.text = "내가 찜한 동영상"
        likeListLabel.font = UIFont.boldSystemFont(ofSize: 30)
        likeListLabel.textColor = .white
        NSLayoutConstraint.activate([
            likeListLabel.topAnchor.constraint(equalTo: profilEditButton.bottomAnchor, constant: .defaultPadding * 2),
            likeListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            likeListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
        ])
    }
    
    func setUpCollectionView(){
        if userDataManager.userData[myId]?.likeList.count == 0{
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .myBackGroundColor
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: likeListLabel.bottomAnchor, constant: .defaultPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        
        view.addSubview(infoLabel)
        infoLabel.text = "찜한 동영상이 없습니다."
        infoLabel.font = UIFont.boldSystemFont(ofSize: 17)
        infoLabel.textColor = .myWhitePointColor
        if userDataManager.userData[myId]?.likeList.count == 0{
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: likeListLabel.bottomAnchor, constant: .defaultPadding),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
        ])
    }

    // MARK: - ButtonTapped

    @objc func logOutButtonTapped(_ sender: UIButton){
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let oklAction = UIAlertAction(title: "ok", style: .destructive) { _ in  let vc = SignInViewController()
            self.userDataManager.autoLogin = false
            self.userDataManager.setData()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: true)}
        alert.addAction(cancelAction)
        alert.addAction(oklAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func didTapEditButton(){
        let alert = UIAlertController(title: "닉네임 수정", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "ok", style: .destructive) {_ in
            guard let newNickName = alert.textFields?[0].text else { return }
            if self.userDataManager.userData[self.myId] != nil {
                self.userDataManager.userData[self.myId]!.nickName = newNickName
                self.userDataManager.setData()
                self.nickNameLabel.text = "안녕하세요 \(newNickName) 님"
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { (textField) in
            textField.placeholder = "변경하실 닉네임을 입력해주세요."
        }
        present(alert, animated: true, completion: nil)
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UserDataManager.shared.userData[String(UserDataManager.shared.loginId)]?.likeList.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
        //셀에 접근해서 setlikeImage 함수에다 url 넣어줌
        if userDataManager.userData[myId] != nil {
//            cell.setlikeImage(with: "https://img.youtube.com/vi/\((UserDataManager.shared.userData[myId]!.likeList[indexPath.row]))/0.jpg")
            cell.bind(videoID: userDataManager.userData[myId]!.likeList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        guard let userData = userDataManager.userData[myId] else {return}
        
        VideoURLService().getVideoInfo(userData.likeList[indexPath.row]) { [weak self] items in
            guard let self = self else { return }
            if let item = items.first{
                let videoId = userData.likeList[indexPath.row]
                vc.videoBind(videoId: videoId, item: item)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight: CGFloat = 260
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

