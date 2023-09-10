//
//  ThumbnailCell.swift
//  YouTubeApp
//
//  Created by t2023-m0062 on 2023/09/05.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    static let identifier = "ThumbnailCell"
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true  //이미지 뷰 셀 경계에 맞게 설정
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = ""
        title.font = UIFont.systemFont(ofSize: 17)
        title.textColor = .white
        title.numberOfLines = 0
        //title.backgroundColor = .red
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
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
                self.titleLabel.text = item.snippet.title //제목 설정
            }
            print(item.snippet.title)
        }
// 제목 UILabel만들고 아래 값 추가해주기. snipet에 영상 설명이나 시간 등 여러 타입 있어서 나타내 줄 수 있음!
//        item.snippet?.channelTitle
    }
    
    private func setupUI() {
        //backgroundColor = .systemBlue
        addSubview(thumbnailImageView)  //이미지 뷰를 셀에 추가
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
        
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}
