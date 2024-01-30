//
//  ContainerView.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/29.
//

import UIKit

class ContainerView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var colors: [UIColor] = [.red, .green, .blue, .brown, .purple]
    
    weak var delegate: ChildViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize = .init(width: scrollView.bounds.width * CGFloat(colors.count), height: scrollView.bounds.height)
    }
    
    func setupViews() {
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        
    }

    func configure() {
        
        scrollView.subviews.forEach { v in
            v.removeFromSuperview()
        }
        
        let childPageCount = colors.count
        
        var lastView: ChildView? = nil
        for i in 0..<childPageCount {
            let childView = ChildView(color: colors[i])
            childView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(childView)
            
            let leadingAnchor: NSLayoutConstraint
            if let lastView = lastView {
                leadingAnchor = childView.leadingAnchor.constraint(equalTo: lastView.trailingAnchor)
            } else {
                leadingAnchor = childView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            }
            NSLayoutConstraint.activate([
                childView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                leadingAnchor,
                childView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                childView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
            
            childView.configure()
            childView.delegate = self
            lastView = childView
        }

    }
}

extension ContainerView: ChildViewDelegate {
    
    func childScrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.childScrollViewDidScroll(scrollView)
    }
    
}
