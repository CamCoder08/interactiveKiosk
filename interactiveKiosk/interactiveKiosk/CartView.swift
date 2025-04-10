//
//  CartView.swift
//  interactiveKiosk
//
//  Created by ByonJoonYoung on 4/8/25.
//

import UIKit
import SnapKit

class CartView: UIView, UITableViewDataSource {
    // 테이블뷰 생성
    let tableView = UITableView()

    var cartItems: [CartItem] = []
    var onQuantityChanged: ((String, Int) -> Void)?

    // 커스텀뷰에 쓰는 공식같은 개념...? (UIView의 초기화 및 자동 호출)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()

    }
    // 커스텀뷰에 쓰는 공식 (커스텀뷰를 코드베이스로 구현할 때 필요한 코드)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func reload(with items: [CartItem]) {
        self.cartItems = items
        tableView.reloadData()
    }



    
    
    // 테이블뷰 설정 (override init안에서 호출 및 자동실행)
    func setTableView() {
        tableView.backgroundColor = UIColor(hex: "E9EDC9")
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // 테이블뷰 상하좌우 전체를 부모 뷰(CartView)에 딱 꽉채우게 설정
        }
        // 데이터 공급 주체인 self(CartView)가 UITableViewDataSource 프로토콜 채택하여 데이터 제공하게 됨
        tableView.dataSource = self
        tableView.rowHeight = 50 // 각 셀의 높이
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        // 테이블뷰에 사용할 셀(CartCell 클래스)를 등록, 셀의 사용(재사용)을 위한 ID 설정
    }

    // UITableViewDataSource 포토토콜을 채택했을 때 필수로 구현해야함.
    // 해당 섹션에 몇 줄이 필요한지 설정하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count // cartItem 배열에 들어있는 항목 개수만큼 줄이 필요
    }
    
    
    // UITableViewDataSource 포토토콜을 채택했을 때 필수로 구현해야함.
    // 셀을 몇번째 줄에 그릴지 데이터를 꺼내는 함수 (이해 완벽히 안됨 공부 더 필요)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! 강제 타입변환도 가능하지만, 안전한 처리를 위해 guard let 옵셔널 바운딩 했음 (규섭님 ㄱㅅㄱㅅ)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else { return UITableViewCell() }

        let item = cartItems[indexPath.row] // 현재 줄에 해당하는 데이터 꺼내기
        cell.setData(name: item.name, count: item.quantity, price: item.price) // 셀에 값 넣기
        cell.backgroundColor = UIColor(hex: "E9EDC9")
        cell.selectionStyle = .none 

        cell.plus = {
            self.cartItems[indexPath.row].quantity += 1
            self.tableView.reloadData() // 해당 셀에 최신 정보 업데이트
        }

        cell.minus = {
            self.onQuantityChanged?(item.name, -1)
            self.tableView.reloadData() // 해당 셀에 최신 정보 업데이트
        }
        return cell // 최종 설정된 셀을 테이블뷰로 반환

    }
}


// 테이블뷰 위에부터 셀이 쌓여야함.



class CartCell: UITableViewCell {
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let priceLabel = UILabel()
    let plusButton = UIButton()
    let minusButton = UIButton()

    var plus: (() -> Void)?
    var minus: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell() {
        nameLabel.font = .systemFont(ofSize: 14)

        countLabel.font = .systemFont(ofSize: 14)
        countLabel.textAlignment = .center

        priceLabel.font = .boldSystemFont(ofSize: 14)

        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.tintColor = UIColor(hex: "658147")
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)

        minusButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        minusButton.tintColor = UIColor(hex: "658147")
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)

        [nameLabel, minusButton, countLabel, plusButton, priceLabel].forEach {
            contentView.addSubview($0)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }

        minusButton.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(25)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }

        countLabel.snp.makeConstraints {
            $0.leading.equalTo(minusButton.snp.trailing).offset(10)
            $0.width.equalTo(30)
            $0.centerY.equalToSuperview()
        }

        plusButton.snp.makeConstraints {
            $0.leading.equalTo(countLabel.snp.trailing).offset(10)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }

    }

    func setData(name: String, count: Int, price: Int) {
        nameLabel.text = name
        countLabel.text = "\(count)"
        priceLabel.text = "\(count * price)원"
    }

    @objc func plusTapped() {
        plus?()
    }

    @objc func minusTapped() {
        minus?()
    }


}
