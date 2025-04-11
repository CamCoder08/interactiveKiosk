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
    
    // ViewController 클래스 내부 가장 위에 추가
    var cartItems: [CartItem] = []
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "ffd6ab")
        logoView.backgroundColor = .clear
        categoryView.backgroundColor = UIColor(hex: "#edc59a")
        categoryView.layer.cornerRadius = 10
        menuView.backgroundColor = UIColor(hex: "#edc59a")
        menuView.layer.cornerRadius = 20
        cartView.layer.cornerRadius = 20
        checkOutView.backgroundColor = .clear
        setupViews()
        setupConstraints()
        
        categoryView.onCategorySelected = { [weak self] selectedIndex in
               self?.menuView.updateCategory(to: selectedIndex)
           }
        
        // 버튼 연결
        checkOutView.cancelButton.addTarget(self, action: #selector(resetCart), for: .touchUpInside)
        checkOutView.payButton.addTarget(self, action: #selector(handlePay), for: .touchUpInside)
        
        // 테스트용 금액 표시 (나중에 함수로 대체)
        checkOutView.orderValueLabel.text = "0원"
        checkOutView.totalValueLabel.text = "0원"
        
        menuView.onMenuSelected = { [weak self] item in
            self?.addToCart(menu: item)
        }
        
        cartView.onQuantityChanged = { [weak self] name, delta in
            self?.changeQuantity(for: name, delta: delta)
            self?.cartView.reload(with: self?.cartItems ?? [])
            self?.updateSummary()
        }


    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func setupViews() {
        [logoView, categoryView, menuView, cartView, checkOutView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        logoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
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
            $0.top.equalTo(cartView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()//.inset(20)
            $0.height.equalTo(160)
        }
    }
    
    func addToCart(menu: MenuItem) {
        if let index = cartItems.firstIndex(where: { $0.name == menu.title }) {
            var existingItem = cartItems[index]
            existingItem.quantity += 1

            cartItems.remove(at: index)
            cartItems.insert(existingItem, at: 0) // 기존 항목을 맨 위로 이동
        } else {
            let newItem = CartItem(name: menu.title, price: menu.price, quantity: 1)
            cartItems.insert(newItem, at: 0) // 새 항목도 항상 맨 위
        }

        updateSummary()
        cartView.reload(with: cartItems)
    }

    
    func changeQuantity(for name: String, delta: Int) {
        guard let index = cartItems.firstIndex(where: { $0.name == name }) else { return }
        
        cartItems[index].quantity += delta
        
        if cartItems[index].quantity <= 0 {
            cartItems.remove(at: index)
        }
        
        updateSummary()
        cartView.reload(with: cartItems) // UI 갱신
    }
    
    func updateSummary() {
        let total = cartItems.reduce(0) { $0 + ($1.price * $1.quantity) }
        checkOutView.updateTotalPrice(orderPrice: total, totalPrice: total)
    }
    
    
    @objc func handlePay() {
        guard !cartItems.isEmpty else {
            showAlert(title: "결제 불가", message: "주문할 메뉴가 없습니다.")
            return
        }
        
        let alert = UIAlertController(title: "결제 완료", message: "결제가 정상적으로 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
        
        // 결제 처리
        cartItems.removeAll()
        updateSummary()
        cartView.reload(with: cartItems)
    }

    
    
    @objc func resetCart() {
        let alert = UIAlertController(title: "전체 취소", message: "주문 내역을 모두 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.cartItems.removeAll()
            self.updateSummary()
            self.cartView.reload(with: self.cartItems)
        }))
        present(alert, animated: true)
    }
}
