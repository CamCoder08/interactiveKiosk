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
        MenuItem(imageName: "mainMenu1", title: "차돌박이 쌀국수", price: 2800, category: .rice),
        MenuItem(imageName: "mainMenu2", title: "양지 쌀국수", price: 2800, category: .rice),
        MenuItem(imageName: "mainMenu3", title: "힘줄 쌀국수", price: 2800, category: .rice),
        MenuItem(imageName: "mainMenu4", title: "해산물 쌀국수", price: 2800, category: .rice),
        MenuItem(imageName: "sideMenu1", title: "사이드메뉴1", price: 1500, category: .side),
        MenuItem(imageName: "sideMenu2", title: "사이드메뉴2", price: 1500, category: .side),
        MenuItem(imageName: "drink1", title: "음료1", price: 1000, category: .drink),
        MenuItem(imageName: "drink2", title: "음료2", price: 1000, category: .drink),
        MenuItem(imageName: "drink3", title: "음료3", price: 1000, category: .drink),
        MenuItem(imageName: "drink4", title: "음료4", price: 1000, category: .drink)
    ]
}

