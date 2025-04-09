//
//  MenuView.swift
//  interactiveKiosk
//
//  Created by ByonJoonYoung on 4/8/25.
//

import UIKit
import SnapKit

class MenuView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let menuItems = [
        ("mainMenu1", "쌀국수1", "2,800원"),
        ("mainMenu2", "쌀국수2", "2,800원"),
        ("mainMenu3", "쌀국수3", "2,800원"),
        ("mainMenu4", "쌀국수4", "2,800원"),
        ("sideMenu1", "사이드메뉴1", "1,500원"),
        ("sideMenu2", "사이드메뉴2", "1,500원"),
        ("drink1", "음료1", "1,000원"),
        ("drink2", "음료2", "1,000원"),
        ("drink3", "음료3", "1,000원"),
        ("drink4", "음료4", "1,000원")
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        collectionView.contentInset = .init(top: 0, left: 30, bottom: 0, right: 30)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let menuItem = menuItems[indexPath.item]
        cell.configure(imageName: menuItem.0, title: menuItem.1, price: menuItem.2)
        return cell
    }
    
    // MARK: - CollectionView Delegate FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let interItemSpacing: CGFloat = 2 // 가로 간격
        let totalSpacing = interItemSpacing * (numberOfColumns - 1)
        let availableWidth = collectionView.frame.width - totalSpacing
        _ = (availableWidth / numberOfColumns)  // ← 가로만 살짝 줄임
        
        let fixedHeight: CGFloat = 130 // ← 세로 높이 고정!

        return CGSize(width: ((collectionView.frame.width -  60) / 2), height: fixedHeight)
    }
}
