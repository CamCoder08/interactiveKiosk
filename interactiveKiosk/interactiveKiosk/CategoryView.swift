import UIKit
import SnapKit

class CategoryView: UIView {

    private let categories = ["쌀국수", "사이드", "음료"]

    var onCategorySelected: ((Int) -> Void)?

    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: categories)
        control.selectedSegmentIndex = 0 //첫번째 항목인 "쌀국수"기본 선택

        control.selectedSegmentTintColor = UIColor(hex: "#bc5923")
        control.backgroundColor = UIColor(hex: "F6995C")

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        control.setTitleTextAttributes(normalAttributes, for: .normal)
        control.setTitleTextAttributes(selectedAttributes, for: .selected)

        control.setTitleTextAttributes([
                .font: UIFont(name: "BMHANNAPro", size: 14) ?? .systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ], for: .normal)

            control.setTitleTextAttributes([
                .font: UIFont(name: "BMHANNAPro", size: 14) ?? .systemFont(ofSize: 14),
                .foregroundColor: UIColor.white
            ], for: .selected)

        control.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .clear
        addSubview(segmentedControl)

        segmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8) //top, bottom, leading, trailing 모든 방향에서 8
        }
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        print("선택된 인덱스: \(selectedIndex), 카테고리: \(categories[selectedIndex])")
        
        onCategorySelected?(selectedIndex)
    }
}
