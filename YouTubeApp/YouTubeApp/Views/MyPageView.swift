//
//  MyPageView.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class MyPageView: UICollectionViewCell {
    
    public let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func setUp(){
        setUpProfileImageView()
    }
    // 셀에 있는 이미지에다 url 이미지를 불러와주는 함수
    func setlikeImage(with feedElement: String) {
        imageView.loadImage(url: feedElement)
    }

    func setUpProfileImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .green
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
