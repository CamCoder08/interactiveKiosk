import UIKit
import SnapKit

class LogoView: UIView {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        self.addSubview(logoImageView)

        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)      // 상단 여백 (상태바 고려)
            $0.leading.equalToSuperview().inset(1)   // 왼쪽 여백
            $0.height.equalTo(30)                    // 적절한 높이
            $0.width.lessThanOrEqualTo(120)          // 너무 커지지 않도록 제한
    }
  }
}

