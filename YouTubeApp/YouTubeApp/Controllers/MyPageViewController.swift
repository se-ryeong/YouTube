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
        let vc = SignInViewController()
        UserDataManager.shared.autoLogin = false
        UserDataManager.shared.setData()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: true)
    }
    
    

    
}

extension MyPageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyPageView
        
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
