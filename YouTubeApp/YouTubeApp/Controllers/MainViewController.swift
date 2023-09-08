//
//  MainViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    var videoItems: [Item] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false //오토레이아웃 쓰려면 무조건 false로
        view.backgroundColor = .black
        view.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        
        layout.minimumLineSpacing = 30
        
        return view
    }()

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "movielogo")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
//    let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "Frame")
//        imageView.contentMode = .scaleAspectFit
//
//        return imageView
//    }()
    
    // MARK: - Init
    //전달할 값 없으니까 init굳이 안만들고 기본생성자 사용
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addSubViews()
        logolayout()
       // imagelayout()
        collectionViewLayout()
        //collectionView를 view에 추가
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationController?.isNavigationBarHidden = true
        
        YouTubeService().fetchYouTubeThumbnails{ [weak self] items in
            self?.videoItems = items
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    //다른 뷰 컨트롤러로 이동할때 다시 보여주기
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    //다시 돌아올때 다시 숨기기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //순서: addSubViews(레이아웃이 겹치는 경우 순서 중요) 먼저 해주고, 오토레이아웃 지정해주기
    func addSubViews() {
        view.addSubview(collectionView)
        view.addSubview(logoImageView)
       // view.addSubview(profileImageView)
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
    
//    func imagelayout() {
//        NSLayoutConstraint.activate([
//            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
//        ])
//    }
    
    func collectionViewLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

//    func collectionViews(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width / 2 - 10, height: 220)
//    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
        cell.configureCell(item: videoItems[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //스크롤 내릴 때 tabbar 사라지고 스크롤 올릴 때 다시 올라오게 설정
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard velocity.y != 0 else { return }
            if velocity.y < 0 { //아래로 내릴 때
                let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                self?.tabBarController?.tabBar.alpha = 1.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
            } else { //위로 올릴 때
                self?.tabBarController?.tabBar.alpha = 0.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
            }
            
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width - 30
        let cellHeight: CGFloat = 260
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0  //셀 간 간격
    }
}
