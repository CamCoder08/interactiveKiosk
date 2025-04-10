//
//  CheckOutView.swift
//  interactiveKiosk
//
//  Created by ByonJoonYoung on 4/8/25.
//

import UIKit
import SnapKit

class CheckOutView: UIView {    
     
     // 금액 업데이트할 때 사용할 수 있음
     func updateTotalPrice(orderPrice: Int, totalPrice: Int) {
         orderValueLabel.text = "\(orderPrice)원"
         totalValueLabel.text = "\(totalPrice)원"
     }
    // 컨테이너 뷰 (회색 박스)
    private let summaryContainer = UIView()

    // 텍스트 라벨
    let orderTextLabel = UILabel()
    let totalTextLabel = UILabel()

    // 값 라벨 (연산 결과)
    let orderValueLabel = UILabel()
    let totalValueLabel = UILabel()

    // 버튼
    let cancelButton = UIButton(type: .system)
    let payButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 컨테이너 스타일
        summaryContainer.backgroundColor = UIColor(hex: "#E9EDC9")
        summaryContainer.layer.cornerRadius = 12
        addSubview(summaryContainer)

        // 텍스트 라벨
        orderTextLabel.text = "주문금액"
        totalTextLabel.text = "결제금액"
        [orderTextLabel, totalTextLabel].forEach {
            $0.font = UIFont(name: "BMHANNAPro", size: 16)
            $0.textColor = UIColor(hex: "3d3d3d")
            summaryContainer.addSubview($0)
        }

        // 값 라벨
        orderValueLabel.text = "0원"
        totalValueLabel.text = "0원"
        [orderValueLabel, totalValueLabel].forEach {
            $0.font = UIFont(name: "BMHANNAPro", size: 16)
            $0.textColor = UIColor(hex: "3d3d3d")
            $0.textAlignment = .right
            summaryContainer.addSubview($0)
        }

        // 버튼
        cancelButton.setTitle("전체 취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "BMHANNAPro", size: 16)
        cancelButton.setTitleColor(UIColor(hex: "3d3d3d"), for: .normal)
        cancelButton.backgroundColor = UIColor(hex: "#D1BB9E")
        cancelButton.layer.cornerRadius = 10

        payButton.setTitle("결제 하기", for: .normal)
        payButton.titleLabel?.font = UIFont(name: "BMHANNAPro", size: 16)
        payButton.setTitleColor(UIColor(hex: "3d3d3d"), for: .normal)
        payButton.backgroundColor = UIColor(hex: "#F6995C")
        payButton.layer.cornerRadius = 10

        [cancelButton, payButton].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        summaryContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }

        // 주문 텍스트
        orderTextLabel.snp.makeConstraints {
            $0.top.equalTo(summaryContainer.snp.top).offset(15)
            $0.leading.equalTo(summaryContainer).offset(20)
        }

        orderValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(orderTextLabel)
            $0.trailing.equalTo(summaryContainer).offset(-20)
        }

        // 총 결제 금액
        totalTextLabel.snp.makeConstraints {
            $0.top.equalTo(orderTextLabel.snp.bottom).offset(8)
            $0.leading.equalTo(orderTextLabel)
        }

        totalValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalTextLabel)
            $0.trailing.equalTo(orderValueLabel)
        }

        cancelButton.snp.makeConstraints {
            $0.top.equalTo(summaryContainer.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(payButton.snp.leading).offset(-16)
            $0.height.equalTo(44)
            $0.width.equalTo(payButton)
        }

        payButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(160)
        }
    }
}

