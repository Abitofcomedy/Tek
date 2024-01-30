//
//  ItemCell.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/30.
//

import UIKit
import SnapKit

class ItemCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = UIColor(hexString: "#333333")
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = UIColor(hexString: "#999999")
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        let att = NSMutableAttributedString()
        att.append(.init(string: "1380", attributes: [.foregroundColor: UIColor(hexString: "#DB0011")!, .font: UIFont.systemFont(ofSize: 19, weight: .bold)]))
        att.append(.init(string: "积分", attributes: [.foregroundColor: UIColor(hexString: "#DB0011")!, .font: UIFont.systemFont(ofSize: 9, weight: .medium)]))
        label.attributedText = att
        label.masksToBounds = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        contentView.backgroundColor = .white
        contentView.layerCornerRadius = 16
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(21)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(12)
        }
        
        contentView.addSubview(pointLabel)
        pointLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(subtitleLabel)
//            make.height.equalTo(13)
        }
    }
}
