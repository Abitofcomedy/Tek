//
//  ChildView.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/29.
//

import UIKit

protocol ChildViewDelegate: NSObjectProtocol {
    func childScrollViewDidScroll(_ scrollView: UIScrollView)
}

class ChildView: UIView {

    enum Section: Hashable {
        case main
    }
    
    struct Item: Hashable, Identifiable {
        let id = UUID().uuidString
    }
    
    let color: UIColor
    weak var delegate: ChildViewDelegate?
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: String(describing: ItemCell.self))
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(hexString: "#F2F2F2")
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        
        backgroundColor = color
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        collectionView.collectionViewLayout = makeLayout()
        makeDataSource()
        
        collectionView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { _, environment in
            let spacing: CGFloat = 7
            let edgeInset: CGFloat = 12
            let itemWidth = (environment.container.contentSize.width - edgeInset * 2 - spacing) / 2
            let itemHeight = itemWidth / 172 * 256
            let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
            let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(itemHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: edgeInset, leading: edgeInset, bottom: edgeInset, trailing: edgeInset)
            return section
        }
        return layout
    }
    
    func makeDataSource() {
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCell.self), for: indexPath)
            
            return cell
        }
        
        self.dataSource = dataSource
    }
    
    func configure() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([.init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init()], toSection: .main)
        dataSource.apply(snapshot)
    }
    
}

extension ChildView: UICollectionViewDelegate {
    
}

extension ChildView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.childScrollViewDidScroll(scrollView)
    }
    
}
