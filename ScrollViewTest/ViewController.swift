//
//  ViewController.swift
//  ScrollViewTest
//
//  Created by Guanghao Zhang on 2024/1/29.
//

import UIKit

class MyTableView: UITableView, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

class ViewController: UIViewController {

    enum Section: Hashable {
        case main
        case benefit
        case collectionView
    }
    
    enum Item: Hashable {
        case item(id: String)
        case benefit
        case collectionView
    }
    
    let tableView = MyTableView(frame: .zero, style: .plain)
    var isOutterScrollViewScrollEnabled = true
    var isInnerScrollViewScrollEnabled = false
    
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(SegmentedViewCell.self, forCellReuseIdentifier: String(describing: SegmentedViewCell.self))
        tableView.register(cellWithClass: BenefitHomeFreeBenefitCell.self)
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        makeDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main, .benefit, .collectionView])
        var items: [Item] = []
        (1...30).forEach { _ in
            items.append(.item(id: UUID().uuidString))
        }
        snapshot.appendItems(items, toSection: .main)
        snapshot.appendItems([Item.benefit], toSection: .benefit)
        snapshot.appendItems([Item.collectionView], toSection: .collectionView)
        dataSource.apply(snapshot)
        
    }

    func makeDataSource() {
        let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .item(let id):
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                cell.textLabel?.text = id
                return cell
            case .benefit:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BenefitHomeFreeBenefitCell.self), for: indexPath) as! BenefitHomeFreeBenefitCell
                cell.configure()
                return cell
            case .collectionView:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentedViewCell.self), for: indexPath) as! SegmentedViewCell
                cell.configure()
                cell.containerView.delegate = self
                return cell
            }
        }
        self.dataSource = dataSource
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let maxOffsetY: CGFloat = tableView.rectForRow(at: IndexPath(item: 0, section: 1)).origin.y
        if isOutterScrollViewScrollEnabled {
            if scrollView.contentOffset.y >= maxOffsetY {
                scrollView.contentOffset.y = maxOffsetY
                isOutterScrollViewScrollEnabled = false
                isInnerScrollViewScrollEnabled = true
            }
        } else {
            scrollView.contentOffset.y = maxOffsetY
            isInnerScrollViewScrollEnabled = true
        }
    }
}

extension ViewController: ChildViewDelegate {
    
    func childScrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isInnerScrollViewScrollEnabled {
            if scrollView.contentOffset.y <= 0 {
                scrollView.contentOffset = .zero
                isOutterScrollViewScrollEnabled = true
                isInnerScrollViewScrollEnabled = false
            }
        } else {
            scrollView.contentOffset = .zero
        }
    }
    
}
