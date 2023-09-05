//
//  MainViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Properties

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false //오토레이아웃 쓰려면 무조건 false로
        view.backgroundColor = .white
        view.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        
        return view
    }()

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "movielogo")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Frame")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Init
    //전달할 값 없으니까 init굳이 안만들고 기본생성자 사용
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        logolayout()
        imagelayout()
        collectionViewLayout()
        //collectionView를 view에 추가
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //순서: addSubViews(레이아웃이 겹치는 경우 순서 중요) 먼저 해주고, 오토레이아웃 지정해주기
    func addSubViews() {
        view.addSubview(collectionView)
        view.addSubview(logoImageView)
        view.addSubview(profileImageView)
    }
    
    func setLayout() {
        //여기에 밑에 있는 함수 넣어서 깔끔하게 정리하기
    }
    
    func logolayout() {
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func imagelayout() {
        NSLayoutConstraint.activate([
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func collectionViewLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight: CGFloat = 220
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return insets
    }
}
