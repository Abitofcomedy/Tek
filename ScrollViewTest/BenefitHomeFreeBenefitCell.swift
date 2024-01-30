//
//  BenefitHomeFreeBenefitCell.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/30.
//

import UIKit

class BenefitHomeFreeBenefitCell: UITableViewCell {

    let freeBenefitView: BenefitHomeFreeBenefitView = {
        let view = BenefitHomeFreeBenefitView()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        backgroundColor = .clear
        
        contentView.addSubview(freeBenefitView)
        freeBenefitView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).priority(.high)
            make.trailing.equalTo(contentView)
        }
    }

    func configure() {
        freeBenefitView.configure()
    }
}
