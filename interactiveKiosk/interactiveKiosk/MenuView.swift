// MenuView.swift
// 메뉴 항목을 컬렉션 뷰로 보여주고, 장바구니에 추가하는 기능 제공

import UIKit
import SnapKit

// 메뉴 리스트를 보여주는 전체 뷰
class MenuView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // 외부에서 접근 가능한 장바구니 뷰
    var cartView: CartView?

    // 현재 표시 중인 메뉴 목록 (카테고리 선택에 따라 갱신)
    var currentMenus: [MenuItem] = []
    var onMenuSelected: ((MenuItem) -> Void)? 

    // 카테고리 선택에 따라 메뉴 목록 필터링
    func updateCategory(to index: Int) {
        switch index {
        case 0:
            currentMenus = MenuItem.sampleData.filter { $0.category == .rice }
        case 1:
            currentMenus = MenuItem.sampleData.filter { $0.category == .side }
        case 2:
            currentMenus = MenuItem.sampleData.filter { $0.category == .drink }
        default:
            currentMenus = []
        }
        collectionView.reloadData()
    }

    // 컬렉션 뷰 정의 및 설정
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        cv.contentInset = .init(top: 15, left: 30, bottom: 0, right: 30)
        return cv
    }()

    // 초기화 시 기본 메뉴와 뷰 구성
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentMenus = MenuItem.sampleData.filter { $0.category == .rice }
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMenus.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
        }

        let item = currentMenus[indexPath.item]
        cell.configure(imageName: item.imageName, title: item.title, price: "\(item.price)원")
        cell.menuName = item.title
        cell.menuPrice = item.price
        cell.menuView = self // 장바구니 접근 위해 참조 설정
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

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

// MARK: - 메뉴 셀 정의

class MenuCell: UICollectionViewCell {

    private let button = UIButton()        // 메뉴 이미지 버튼
    private let titleLabel = UILabel()     // 메뉴명
    private let priceLabel = UILabel()     // 가격

    var menuName: String = ""              // 메뉴명 텍스트
    var menuPrice: Int = 0                 // 가격 값
    weak var menuView: MenuView?           // 소속 뷰 참조

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        button.addTarget(self, action: #selector(menuTapped), for: .touchUpInside) // ✅ 추가!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 셀 내부 뷰 구성 및 제약 설정
    private func setupViews() {
        contentView.addSubview(button)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(65)
        }

        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(4)
        }

        priceLabel.font = .systemFont(ofSize: 12)
        priceLabel.textColor = .darkGray
        priceLabel.textAlignment = .center
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
        }
    }

















    // 셀에 데이터 바인딩
    func configure(imageName: String, title: String, price: String) {
        button.setImage(UIImage(named: imageName), for: .normal)
        titleLabel.text = title
        priceLabel.text = price
    }
    
    @objc private func menuTapped() {
        let item = MenuItem(imageName: "", title: menuName, price: menuPrice, category: .rice) // category는 무조건 rice 말고 그냥 따로 받아야 좋음
        menuView?.onMenuSelected?(item) // ✅ 클로저 실행
    }

}
