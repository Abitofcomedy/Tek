//
//  BenefitHomeFreeBenefitView.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/30.
//

import UIKit

class BenefitHomeFreeBenefitView: UIView {

    enum Section: Hashable {
        case main
    }
    
    struct Item: Hashable, Identifiable {
        let id = UUID().uuidString
        let title: String
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "免费领权益"
        label.textColor = UIColor(hexString: "#111111")
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(cellWithClass: FreeBenefitItemCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        collectionView.collectionViewLayout = makeStyle1Layout()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(90)
        }
        
        makeDataSource()
    }
    
    func makeStyle1Layout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
    
    func makeStyle2Layout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
    
    func makeDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withClass: FreeBenefitItemCell.self, for: indexPath)
            cell.configure(model: itemIdentifier)
            return cell
        }
        
        self.dataSource = dataSource
    }
    
    func configure() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        
        let items = [
            Item(title: "财富问诊"), Item(title: "海外留学"), Item(title: "领重疾险"),
            Item(title: "赠送积分"), Item(title: "免费洗车"), Item(title: "免费午餐"),
            Item(title: "免费午餐"), Item(title: "免费午餐")
        ]
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
        
        if items.count > 6 {
            collectionView.setCollectionViewLayout(makeStyle2Layout(), animated: false)
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(90)
            }
        } else {
            collectionView.setCollectionViewLayout(makeStyle1Layout(), animated: false)
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        }
    }
}
