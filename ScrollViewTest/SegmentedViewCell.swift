//
//  SegmentedViewCell.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/29.
//

import UIKit

class SegmentedViewCell: UITableViewCell {

    let containerView: ContainerView = {
        let view = ContainerView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.addSubview(containerView)
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomConstraint,
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 84 - 34)
        ])
    }

    func configure() {
        containerView.configure()
    }
}
