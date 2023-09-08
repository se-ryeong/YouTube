//
//  HorizontalCollectionViewCell.swift
//  YouTubeApp
//
//  Created by 랑 on 2023/09/09.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HorizontalCollectionViewCell"
    
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: Item) {
        let urlString = item.snippet.thumbnails.high.url
        DispatchQueue.global().async {
            guard let url = URL(string: urlString),
                  let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.thumbnailImageView.image = UIImage(data: imageData)
                self.titleLabel.text = item.snippet.title
            }
        }
// 제목 UILabel만들고 아래 값 추가해주기. snipet에 영상 설명이나 시간 등 여러 타입 있어서 나타내 줄 수 있음!
//        item.snippet?.channelTitle
    }
    
    private func setUpView() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.image = UIImage(systemName: "photo")
        thumbnailImageView.backgroundColor = .myRedPointColor
        thumbnailImageView.tintColor = .white
        thumbnailImageView.clipsToBounds = true
        addSubview(thumbnailImageView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),
            //thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor, multiplier: 16.0/9.0)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textColor = .myWhitePointColor
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

