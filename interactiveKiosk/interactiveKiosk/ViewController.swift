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
        
        // 버튼 연결
        checkOutView.cancelButton.addTarget(self, action: #selector(resetCart), for: .touchUpInside)
        checkOutView.payButton.addTarget(self, action: #selector(handlePay), for: .touchUpInside)

        // 테스트용 금액 표시 (나중에 함수로 대체)
        checkOutView.orderValueLabel.text = "12,000원"
        checkOutView.totalValueLabel.text = "12,000원"

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
            $0.height.equalTo(160)
        }
    }
    
    @objc func resetCart() {
        let alert = UIAlertController(title: "전체 취소", message: "주문 내역을 모두 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            // 실제 장바구니 삭제 함수 들어갈 자리
            print("장바구니 초기화")
        }))
        present(alert, animated: true)
    }

    @objc func handlePay() {
        let alert = UIAlertController(title: "결제 완료", message: "결제가 정상적으로 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

}
