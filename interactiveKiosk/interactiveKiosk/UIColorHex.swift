//
//  UIColorHex.swift
//  interactiveKiosk
//
//  Created by ByonJoonYoung on 4/8/25.
//

import UIKit
import SnapKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex
        if hexValue.hasPrefix("#") {
            hexValue.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

/*
 적용 예시
 let bgColor = UIColor(hex: "#FEFAE0") Hex 컬러 조절
 let dimmed = UIColor(hex: "F6995C", alpha: 0.5) 알파값 조절 포함
 */

