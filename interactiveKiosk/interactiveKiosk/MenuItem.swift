// MenuItem.swift

import Foundation

struct MenuItem {
    let imageName: String
    let title: String
    let price: Int
    let category: Category

    enum Category {
        case rice, side, drink
    }

    static let sampleData: [MenuItem] = [
        // 쌀국수류 메뉴
        MenuItem(imageName: "mainMenu1", title: "해산물 쌀국수", price: 5000, category: .rice),
        MenuItem(imageName: "mainMenu2", title: "힘줄 쌀국수", price: 5000, category: .rice),
        MenuItem(imageName: "mainMenu3", title: "양지 힘줄 쌀국수", price: 5500, category: .rice),
        MenuItem(imageName: "mainMenu4", title: "차돌 양지 쌀국수", price: 5500, category: .rice),
        MenuItem(imageName: "mainMenu5", title: "양지 쌀국수", price: 4500, category: .rice),
        MenuItem(imageName: "mainMenu6", title: "차돌 쌀국수", price: 5000, category: .rice),

        // 사이드 메뉴
        MenuItem(imageName: "sideMenu1", title: "짜조 2ps", price: 1500, category: .side),
        MenuItem(imageName: "sideMenu2", title: "버팔로윙 3ps", price: 1500, category: .side),

        // 음료 메뉴
        MenuItem(imageName: "drink1", title: "사이공 맥주", price: 1000, category: .drink),
        MenuItem(imageName: "drink2", title: "하노이 맥주", price: 1000, category: .drink),
        MenuItem(imageName: "drink3", title: "펩시", price: 1000, category: .drink),
        MenuItem(imageName: "drink4", title: "스프라이트", price: 1000, category: .drink)
    ]
}
