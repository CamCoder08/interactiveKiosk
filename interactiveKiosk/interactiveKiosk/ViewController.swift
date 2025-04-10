//
//  ViewController.swift
//  interactiveKiosk
//
//  Created by ByonJoonYoung on 4/7/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let logoView = LogoView()
    let categoryView = CategoryView()
    let menuView = MenuView()
    let cartView = CartView()
    let checkOutView = CheckOutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        logoView.backgroundColor = .white
        categoryView.backgroundColor = .white
        menuView.backgroundColor = .white
        cartView.layer.cornerRadius = 10
        checkOutView.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        [logoView, categoryView, menuView, cartView, checkOutView].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        logoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }

        // 카테고리 버튼 영역
        categoryView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        // 메뉴 뷰
        menuView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(270)
        }

        // 장바구니 (주문 내역)
        cartView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }

        // 주문 금액 총합
        checkOutView.snp.makeConstraints {
            $0.top.equalTo(cartView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(130)
        }
    }
}
