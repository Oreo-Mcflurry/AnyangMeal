
![APP Icon](https://github.com/Oreo-Mcflurry/AnyangMeal/assets/96654328/a4610c4e-b786-4d84-b5ad-fd18c4851956)

## [출시] 아냥식 | 2023.09.17 ~ 2023.09.18 (2일), 2024.02 프로젝트 종료

<aside>
⭐ 안양대학교의 학식을 편리하게!

안양대학교의 학생들은 학식을 확인하기 위해 주로 안양대학교의 웹사이트에 직접 들어가 확인해야 했습니다. 이를 개선하기 위해 바로 학식의 정보를 바로 알려줄 수 있는 앱을 만들었습니다.

</aside>

![스크린샷 2024-03-25 02 11 01](https://github.com/Oreo-Mcflurry/AnyangMeal/assets/96654328/6865970c-168d-4f71-a66d-73e10c26af5d)

## 🔗 앱스토어 링크 (중단)

[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/%EC%95%84%EB%83%A5%EC%8B%9D/id6466650207)

## 🧑‍🤝‍🧑 팀구성

- 1인 개발

### 🔨 기술 스택 및 사용한 라이브러리

- SwiftUI
- Alamofire
- MVVM
- Node.js
- WatchOS

### 👏 해당 기술을 사용하며 이룬 성과

- 기존에는 SwiftSoup와 CoreData를 이용하여 일주일에 한번 웹 사이트를 크롤링 해오는 식으로 구현
- 학교 서버에 대한 부담을 덜기 위함과, 좋아요 기능등의 추가를 이유로 Node.js 서버를 만들어 도입


### 🌠 Trouble Shooting 및 배운 점

- 기존에는 서버에서 학식 정보를 받아오기 전 까지 ‘학식 정보가 없습니다’를 보여주었으나, 서버의 성능이 좋지 않은 탓에 유저는 오랫동안 정보가 없다는 문구만 보고있었어야 했었음
- 이를 해결하기 위해 Alamofire와 CompletionHandler 클로저 구문을 이용하여 서버에서 정보를 받기 전 / 후로 나뉘어 ‘학식 정보를 불러오고 있습니다’ 와 ‘학식 정보가 없습니다’를 분리하여 UI/UX를 개선

### 📋 Post Mortem

- 아쉬웠던 점
  - 업데이트 하고 싶은 기능이 많았는데, 전부 해보지 못하고 중단하게 된 점이 아쉬움
