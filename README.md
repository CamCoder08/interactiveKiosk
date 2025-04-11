
# PHởrder - 베트남 쌀국수 키오스크 앱

> 베트남 쌀국수 전문점의 키오스크 UI를 iOS 앱으로 구현한 팀 프로젝트입니다.  
> UIKit과 SnapKit 기반의 100% 코드베이스로, UX 흐름 설계부터 컴포넌트 분리, 협업 브랜치 전략까지 경험해보는 데 집중했습니다.

---

## 1. 프로젝트 개요

- **프로젝트명**: PHởrder (포오더)
- **주제**: 키오스크 앱 UI/UX 설계 및 구현
- **개발 기간**: 2025.04.07 ~ 2025.04.11
- **개발 목표**:
  - 사용자 중심의 메뉴 선택 → 장바구니 → 결제 흐름 구현
  - UIKit 기반 UI 컴포넌트 및 레이아웃 학습
  - Git 브랜치 전략을 통한 팀 협업

---

## 2. 사용 기술 및 구조

| 분류 | 기술/도구 |
|------|-----------|
| 언어 | Swift |
| UI 프레임워크 | UIKit + SnapKit |
| 구조 패턴 | MVC 기반 |
| UI 구성요소 | `UICollectionView`, `UITableView`, `UISegmentedControl`, `UIButton`, `UIImageView`, `UIAlertController` |
| 디자인 요소 | 커스텀 폰트, Hex 색상 코드 사용 |

---

## 📂 프로젝트 구조

```plaintext
interactiveKiosk/
├── Font/                      # 커스텀 폰트 파일
├── Assets/                   # 이미지 및 색상 에셋
├── Model/
│   └── CartItem.swift        # 장바구니 모델 구조체
├── View/
│   ├── LogoView.swift
│   ├── CategoryView.swift
│   ├── MenuView.swift
│   ├── CartView.swift
│   └── CheckOutView.swift
├── Controller/
│   └── ViewController.swift  # 전체 UI 제어 및 로직 처리
├── Support/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── SplashViewController.swift

```
---

## 3. 앱 주요 화면

 ![스크린샷 2025-04-11 17 27 01](https://github.com/user-attachments/assets/f53d88a3-fe6a-4d94-84a1-cbfbc9f9fe36) 

> 메뉴 선택 → 장바구니 → 수량 조절 → 전체취소 및 결제까지의 흐름이 구현되어 있습니다.  
> **장바구니가 비었을 때 문구 안내**, **Alert 예외처리** 등 UX 세부 요소도 반영했습니다.

---

## 4. 주요 색상 (Hex 기준)

| 항목 | 색상 코드 | 설명 |
|------|------------|------|
| 전체 배경 | `#FFD6AB` | 따뜻한 베트남 느낌의 배경 |
| 커스텀뷰 배경 | `#EDC59A` | 카드 뷰, 장바구니 |
| 텍스트 | `#5E3E2F`, `#14100E` | 메인/강조 텍스트 |
| 카테고리 | `#BC5923` (선택), `#F6995C` (비선택) |
| 수량 버튼 | `#33251D` |
| 결제 버튼 | `#F6995C` |
| 전체취소 버튼 | `#D1BB9E` |

---
![스크린샷 2025-04-11 17 28 31](https://github.com/user-attachments/assets/6ec17711-839a-4964-a7f7-6e08c879d1a5)

---

## 5. 역할 분담

| 팀원 | 담당 파트 |
|------|-------------|
| 김재우 | `LogoView`, `CategoryView` (상단 로고 및 카테고리 세그먼트) |
| 유승환 | `MenuView` (메뉴 리스트 및 UICollectionView) |
| 변준영 | `CartView` (장바구니 및 UITableView) |
| 김보미 | `CheckOutView` (금액 표시 및 결제/취소 버튼) |
| 공동 작업 | `ViewController`, Git 브랜치 관리, 기능 연결 및 디버깅 공동 진행 |

> 핵심 View 연결, 데이터 전달 로직, Alert 처리 등은 실시간 논의를 통해 공동 구현했습니다.

---

## 6. Git 브랜치 전략
```plaintext
main                # 발표용 최종 결과물 (직접 수정 금지)
│
├─ dev              # 팀 통합 개발 브랜치
│
├─ feature/로그명   # 개인 작업 브랜치
```


### 협업 절차

1. 개인 feature 브랜치 생성
2. 기능 구현 및 커밋 완료
3. dev 브랜치로 Pull Request
4. 팀원 1명 이상 리뷰 및 승인
5. dev에 머지
6. 발표 전 최종적으로 main에 반영

---

## 7. 개선이 필요한 점

- 장바구니 내 `-` 버튼 클릭 시 수량 제한 처리 미흡  
  → 전체취소 이전에는 수량이 1 이하여도 전량 삭제되는 이슈가 존재함
- 데이터 전달 구조의 최적화  
  → ViewController에 많은 로직이 집중되어 있어 향후 구조 개선 필요

---

## 8. 프로젝트를 통해 배운 점

- 코드베이스 UI 구현 및 SnapKit을 통한 AutoLayout 경험
- 커스텀 View 분리와 역할 책임 기반의 설계 훈련
- 실제 사용자 흐름 기반 UX 설계 및 Alert 예외처리
- Git 브랜치 전략, PR 리뷰, merge 등 협업 경험 습득

---

## 9. 마무리 회고

이번 키오스크 프로젝트는 UIKit의 기본기를 다지는 동시에,  
협업 구조 안에서 실제 사용자 흐름을 구현해보는 경험이었습니다.  
코드베이스 UI, 컴포넌트 분리, 데이터 흐름 제어 등 실전적인 구현 능력을 키울 수 있었고,  
짧은 기간임에도 팀원 각자의 책임감 있는 참여 덕분에 완성도 높은 결과를 만들 수 있었습니다.

---

**🔗 GitHub Repository**  
[https://github.com/CamCoder08/interactiveKiosk](https://github.com/CamCoder08/interactiveKiosk)


