//
//  SplashViewContoroller.swift
//  interactiveKiosk
//
//  Created by 김재우 on 4/10/25.
//

// SplashViewController.swift

import UIKit
import SnapKit

class SplashViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let pho = UIImageView()
        pho.image = UIImage(named: "logo") // 에셋에 있는 로고 이미지
        pho.contentMode = .scaleAspectFit
        return pho
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "FEFAE0")

        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(150)
        }

        // 로고 확대 애니메이션 + 메인화면 전환
        UIView.animate(withDuration: 1.2, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { _ in
            self.moveToMain()
        })
    }

    private func moveToMain() {
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        self.present(mainVC, animated: true)
    }
}
