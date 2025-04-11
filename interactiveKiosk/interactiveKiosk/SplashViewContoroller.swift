//
// SplashViewController.swift
// interactiveKiosk
//
// Created by 김재우 on 4/10/25.
//
import UIKit
import SnapKit
import AVFoundation // 오디오 재생을 위한 프레임워크 추가
class SplashViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let pho = UIImageView()
        pho.image = UIImage(named: "logo") // 에셋에 있는 로고 이미지
        pho.contentMode = .scaleAspectFit
        return pho
    }()
    private var player: AVAudioPlayer? // 오디오 플레이어 변수 선언
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "ffd6ab")
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        playSound() // 사운드 재생 시작
        // 로고 확대 애니메이션 + 메인화면 전환
        UIView.animate(withDuration: 1.2, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { _ in
            self.moveToMain()
        })
    }
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "AppIntroSound2", withExtension: "mp3") else {
            print("사운드 파일을 찾을 수 없습니다.")
            return
        }
        // AVAudioPlayer(contentsOf: url)는 오류를 발생시키는 init 이라 do-try-catch 구문으로 작성
        do { // 오류가 발생할 수 있는 코드를 실행하는 블록 시작
            player = try AVAudioPlayer(contentsOf: url) // 오류가 발생할 수 있는 함수나 메서드 앞에 붙임
            player?.volume = 1
            player?.prepareToPlay()
            player?.play()
        } catch { // 오류가 발생했을 때 실행되는 코드 블록
            print("오디오 재생 실패: \(error.localizedDescription)")
        }
    }
    private func moveToMain() {
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        self.present(mainVC, animated: true)
    }
}
