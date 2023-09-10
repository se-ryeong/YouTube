//
//  MainViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var videoItems: [Item] = []
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        
        layout.minimumLineSpacing = 30
        
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "movielogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let searchBar: UITextField = {
        let sb = UITextField()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .myGrayPointColor
        sb.layer.cornerRadius = 8
        sb.attributedPlaceholder = NSAttributedString(string: "Trailer 검색", attributes: [.foregroundColor: UIColor.systemGray])
        sb.textColor = .myWhitePointColor
        sb.addPadding()
        return sb
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addSubViews()
        logolayout()
        searchBarLayout()
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        YouTubeService().fetchYouTubeThumbnails(searchKeyWord: nil, nil) { [weak self] items in
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
    //배경 터치시 키보드 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}

private extension MainViewController{
    //순서: addSubViews(레이아웃이 겹치는 경우 순서 중요) 먼저 해주고, 오토레이아웃 지정해주기
    func addSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func logolayout() {
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func searchBarLayout() {
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .defaultPadding),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.defaultPadding),
            searchBar.heightAnchor.constraint(equalToConstant: 36)

        ])
    }
    
    func collectionViewLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: .defaultPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
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
        vc.bind(videoItems[indexPath.row])
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

extension MainViewController: UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        YouTubeService().fetchYouTubeThumbnails(searchKeyWord: text, nil) { [weak self] items in
            self?.videoItems = items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        self.view.endEditing(true)
        return true
    }
}
