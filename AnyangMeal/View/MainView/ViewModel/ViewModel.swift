//
//  MainViewModel.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 10/25/23.
//

import UIKit

class ViewModel: ObservableObject {
	@Published var meals: (data: [Meal]?, error: APIRequestManager.APICallError?)?
	@Published var currentPage = 0

	init() {
//		fetchData()
		// 더미 메뉴 데이터
		let dummyMenuData: [String] = [
			 "토마토 스파게티\n샐러드\n아이스티",
			 "로제 파스타\n감자튀김\n과일",
			 "그릴드 치킨\n콘샐러드\n레몬 에이드",
			 "새우 볶음밥\n김치\n아이스 아메리카노",
			 "스테이크\n감자그라탕\n바나나 스무디"
		]

		// 더미 좋아요 기기 데이터
		let dummyLikeDevicesData: [[String]] = [
			 ["iPhone X", "iPad Pro", "MacBook Pro"],
			 ["iPhone 12", "Apple Watch Series 6", "Mac Mini"],
			 ["iPad Air", "iMac", "iPhone SE"],
			 ["MacBook Air", "iPhone 13", "Apple Watch SE"],
			 ["Mac Pro", "iPad Mini", "iPhone 11"]
		]

		// 더미 날짜 데이터
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"

		let dummyDates: [Date] = [
			 dateFormatter.date(from: "2024-03-01")!,
			 dateFormatter.date(from: "2024-03-02")!,
			 dateFormatter.date(from: "2024-03-03")!,
			 dateFormatter.date(from: "2024-03-04")!,
			 dateFormatter.date(from: "2024-03-05")!
		]

		// 더미 Meal 데이터 생성

		for i in 0..<dummyMenuData.count {
			 let meal = Meal(id: UUID().uuidString, meal: MealDetail(day: dummyDates[i], menu: dummyMenuData[i], likeDevice: dummyLikeDevicesData[i]))
			meals?.data?.append(meal)
		}
	}

	func callRequest(_ kind: APIURLs) {
		let manager = APIRequestManager()
		manager.callRequest(kind.type, api: kind) { result, error in
			if case .call = kind {
				self.meals?.data = result as? [Meal]
			}
			self.meals?.error = error
		}
	}

	enum ResponseKind {
		case successAndEmptry
		case fail
		case success
	}

	var responseState: ResponseKind {
		if let data = meals?.data, !data.isEmpty {
			return .success
		} else if (meals?.error) != nil {
			return .fail
		} else {
			return .successAndEmptry
		}
	}

#if os(iOS)
	private var deviceID: String {
		return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
	}

	func isLiked(_ data: Meal) -> Bool {
		return data.meal.likeDevice.contains(deviceID)
	}
#endif
}
