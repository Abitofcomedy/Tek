//
//  FreeBenefitItemCell.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/30.
//

import UIKit

class FreeBenefitItemCell: UICollectionViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = UIColor(hexString: "#111111")
        label.font = .systemFont(ofSize: 13, weight: .regular)
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
        
        contentView.backgroundColor = UIColor(hexString: "#F4F2EB")
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.height.width.equalTo(28)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.greaterThanOrEqualToSuperview()
            make.height.equalTo(14)
        }
    }
    
    func configure(model: BenefitHomeFreeBenefitView.Item) {
        
        titleLabel.text = model.title
    }
}
