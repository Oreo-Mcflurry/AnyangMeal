
![APP Icon](https://github.com/Oreo-Mcflurry/AnyangMeal/assets/96654328/a4610c4e-b786-4d84-b5ad-fd18c4851956)

## [출시] 아냥식 | 2023.09.17 ~ 2023.09.18 (2일), 2024.02 프로젝트 종료

<aside>
⭐ 안양대학교의 학식을 편리하게!

안양대학교의 학생들은 학식을 확인하기 위해 주로 안양대학교의 웹사이트에 직접 들어가 확인해야 했습니다. 이를 개선하기 위해 바로 학식의 정보를 바로 알려줄 수 있는 앱을 만들었습니다.

</aside>

![ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ](https://github.com/Oreo-Mcflurry/AnyangMeal/assets/96654328/c86aa0b1-6699-4d99-b30f-cb3ca2b4b2af)



## 🔗 앱스토어 링크 (중단)

[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/%EC%95%84%EB%83%A5%EC%8B%9D/id6466650207)

## 🧑‍🤝‍🧑 팀구성

- 1인 개발
- iOS 15.0+
- watchOS 9.0+

### 🥕 기능

- 학식 정보를 받는 기능
- 학식 날짜별 좋아요 기능

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

#### 1. SwiftSoup을 사용한 데이터 파싱 시 발생하는 예외 처리 문제, Node.js 서버를 도입하여 서버 업데이트로 예외처리를 가능하게 구현, 또한 유저 당일주일에 한번씩 요청에서 서버에서 요청 1회만으로 파싱 요청을 크게 줄임

#### 이전 코드
~~~swift
func fetchMeal() {
    if let url = URL(string: urlString) {
        do {
            let webString = try String(contentsOf: url)
            let document = try SwiftSoup.parse(webString)

            if let inputElement = try document.select("input#mealList").last() {
                let value = try inputElement.attr("value")
   // ....
}
~~~

#### 수정 후 코드

~~~swift
func callRequest(_ kind: APIURLs) {
		let manager = APIRequestManager()
		manager.callRequest(kind.type, api: kind) { result, error in
			if case .call = kind {
				self.meals?.data = result as? [Meal]
			}
			self.meals?.error = error
		}
	}
~~~

#### 2. 서버의 속도가 빠르지 않아 사용자 경험 저하 이슈, 기존에는 정보를 받아오기 전까지 ‘학식 정보가 없습니다’를 오랫동안 표기 하였으나 Alamofire의 Request 구문을 전/후로 나누어 각기 다른 문구를 표시하여 사용자 경험 개선

#### 이전 코드
~~~swift
Group {
    if meals.isEmpty {
        Text("학식 정보가 없습니다.\n이번주가 휴무 이거나,\n방학일 가능성이 있습니다.\n\n\n그것도 아니라면\n개발자가 열심히 작업중입니다.")
            .multilineTextAlignment(.center)
            .font(.title)
    } else {
        List {
            ForEach(meals, id: \.self) { item in
                Section {
                    Text(item.date ?? Date(), formatter: dateformatter)
                        .foregroundStyle(.secondary)
                    Text(item.meal ?? "정보없음")
                }
            }
        }
    }
}
~~~

#### 수정 후 코드
~~~swift
@ViewBuilder
private var mainView: some View {
    switch viewModel.responseState {
    case .successAndEmptry:
        mealEmptyView
    case .fail:
        mealFailView
    case .success:
        mealView
    case .load:
        mealloadView
    }
}
~~~

### 🗂️ 폴더 구조

~~~
📦AnyangMeal
 ┣ 📂Extension
 ┣ 📂Model
 ┣ 📂Service
 ┣ 📂View
 ┃ ┣ 📂InfoView
 ┃ ┃ ┗ 📂View
 ┃ ┗ 📂MainView
 ┃ ┣ 📂View
 ┗ ┃ ┗ 📂ViewModel
~~~

### 📺 앱 구동 화면
| 뷰 | 이미지 |
| --- | --- |
| 메인 뷰 | <img src="https://github.com/Oreo-Mcflurry/AnyangMeal/assets/96654328/7b951b82-65d4-4bbc-958c-289bc0094ee7" width="188" height="408"> |

