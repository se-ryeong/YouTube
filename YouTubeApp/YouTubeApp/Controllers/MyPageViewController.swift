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

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .myBackGroundColor

//            self.view = MyPageView()
            
            collectionView.dataSource = self
            collectionView.delegate = self
            

            view.addSubview(collectionView)
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            // 32 videoLabel
            collectionView.register(MyPageView.self, forCellWithReuseIdentifier: cellID)
        }
}

extension MyPageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyPageView
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 30) / 4, height: (view.frame.width - 30) / 4)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
