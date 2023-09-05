//
//  ThumbnailCell.swift
//  YouTubeApp
//
//  Created by t2023-m0062 on 2023/09/05.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    static let identifier = "ThumbnailCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트테스트ㅠ.ㅠ.ㅠ.ㅠ"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
