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
    
    let idLabel = UILabel()
    
    let likeListLabel = UILabel()
    
    let logOutButton = UIButton()
    
    let profilEditButton = UIButton()
    
    let userDataManager = UserDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 매니저 유저데이터에 접근해서 라이크 리스트 불러옴 거기다 문자열을 추가해줌 videoId
//        userDataManager.userData["1"]?.likeList.append("dOQDn3uREGs")
        setUp()
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
        view.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.text = "안녕하세요 \(userDataManager.loginId) 님"
        idLabel.font = UIFont.boldSystemFont(ofSize: 40)
        idLabel.textColor = .white
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .defaultPadding),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.defaultPadding),
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
        profilEditButton.setTitle("프로필 수정", for: .normal)
        profilEditButton.backgroundColor = .darkGray
        profilEditButton.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            profilEditButton.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: .defaultPadding),
            profilEditButton.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            profilEditButton.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),
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
            UserDataManager.shared.autoLogin = false
            UserDataManager.shared.setData()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: true)}
        alert.addAction(cancelAction)
        alert.addAction(oklAction)
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
        let myId = UserDataManager.shared.loginId
        if UserDataManager.shared.userData[myId] != nil {
            cell.setlikeImage(with: "https://img.youtube.com/vi/\((UserDataManager.shared.userData[myId]!.likeList[indexPath.row]))/0.jpg")
        }
        
        return cell
    }
    
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - (.defaultPadding * 2) - 20) / 3, height: (view.frame.width - 30) / 4)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
// UIImageView extension 함수는 url 이미지를 표시해줌 
extension UIImageView {
    func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
