//
//  MyPageViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

let cellID = "Cell"

final class MyPageViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let MyPageframe = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return MyPageframe
    }()
    
    let nickNameLabel = UILabel()
    
    let likeListLabel = UILabel()
    
    let logOutButton = UIButton()
    
    let profilEditButton = UIButton()
    
    let userDataManager = UserDataManager.shared
    
    lazy var myId = userDataManager.loginId
    
    //Cannot use instance member 'userDataManager' within property initializer; property initializers run before 'self' is available
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 매니저 유저데이터에 접근해서 라이크 리스트 불러옴 거기다 문자열을 추가해줌 videoId
//        userDataManager.userData["1"]?.likeList.append("dOQDn3uREGs")
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
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
        profilEditButton.backgroundColor = .darkGray
        profilEditButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        profilEditButton.layer.cornerRadius = 4
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .myBackGroundColor
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: likeListLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        collectionView.register(MyPageView.self, forCellWithReuseIdentifier: cellID)
    }
    

    

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
            print(newNickName)
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
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UserDataManager.shared.userData[String(UserDataManager.shared.loginId)]?.likeList.count)!
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyPageView
        //셀에 접근해서 setlikeImage 함수에다 url 넣어줌
        if userDataManager.userData[myId] != nil {
            cell.setlikeImage(with: "https://img.youtube.com/vi/\((UserDataManager.shared.userData[myId]!.likeList[indexPath.row]))/0.jpg")
        }
        
        return cell
    }
    
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - (.defaultPadding * 2) - 10) / 3.5
        return CGSize(width: width, height: width)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

