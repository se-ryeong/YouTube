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
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.thumbnailImageView.image = UIImage(data: imageData)
                self.titleLabel.text = item.snippet.title
            }
        }
    }
    
    private func setUpView() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.image = UIImage(systemName: "icloud.square")
        thumbnailImageView.tintColor = .myRedPointColor
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

