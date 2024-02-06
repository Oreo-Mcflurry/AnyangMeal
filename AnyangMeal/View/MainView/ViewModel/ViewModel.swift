//
//  MainViewModel.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 10/25/23.
//

import UIKit

class ViewModel: ObservableObject {
	@Published var meals: [Meal] = []
	@Published var showAlert = false
	@Published var currentPage = 0

	init() {
		fetchData()
	}

	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ko_KR")
		formatter.dateFormat = "M월dd일(EEE)"
		return formatter
	}

	func fetchData() {
		let url = "https://anyang-api.fly.dev/getMeals"
		guard let apiUrl = URL(string: url) else {
			print("Invalid URL")
			return
		}

		 let dateFormatter = DateFormatter()
		 dateFormatter.dateFormat = "yyyy-MM-dd"

		 URLSession.shared.dataTask(with: apiUrl) { data, response, error in
			  DispatchQueue.main.async {
					if let data = data {
						 do {
							  let decoder = JSONDecoder()
							  decoder.dateDecodingStrategy = .formatted(dateFormatter)

							  let decodedData = try decoder.decode([Meal].self, from: data)
							  self.meals = decodedData

							 for index in 0..<self.meals.count {
								 if self.meals[index].meal.day == Date() {
									 self.currentPage = index
									 break;
								 }
							 }
						 } catch {
							  print("Error decoding JSON: \(error)")
						 }
					} else if let error = error {
						 print("Error fetching data: \(error)")
					}
			  }
		 }.resume()
	}

#if os(iOS)
	func getDeviceID() -> String {
		let device = UIDevice.current
		let identifier = device.identifierForVendor?.uuidString
		return identifier ?? "N/A"
	}

	func addDeviceToMealLike(_id : String) {
		guard let url = URL(string: "https://anyang-api.fly.dev/addDeviceToMealLike") else {
			print("Invalid URL")
			return
		}

		let requestData = ["_id": _id, "deviceId": getDeviceID()]
		let jsonData = try? JSONSerialization.data(withJSONObject: requestData)

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = jsonData
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		// 네트워크 호출
		URLSession.shared.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if let data = data {
					// 응답 데이터 처리
					do {
						let response = try JSONDecoder().decode(ResponseModel.self, from: data)
						print(response.message)
						self.fetchData()
					} catch {
						print("Error decoding JSON: \(error)")
					}
				} else if let error = error {
					print("Error making network request: \(error)")
				}
			}
		}.resume()
	}

	func removeDeviceFromMealLike(_id: String) {
		 guard let url = URL(string: "https://anyang-api.fly.dev/removeDeviceFromMealLike") else {
			  print("Invalid URL")
			  return
		 }

		 let requestData = ["_id": _id, "deviceId": getDeviceID()]
		 let jsonData = try? JSONSerialization.data(withJSONObject: requestData)

		 var request = URLRequest(url: url)
		 request.httpMethod = "DELETE" // HTTP 메서드를 DELETE로 설정
		 request.httpBody = jsonData
		 request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		 // 네트워크 호출
		 URLSession.shared.dataTask(with: request) { data, response, error in
			  DispatchQueue.main.async {
					if let data = data {
						 // 응답 데이터 처리
						 do {
							  let response = try JSONDecoder().decode(ResponseModel.self, from: data)
							  print(response.message)
							  self.fetchData()
						 } catch {
							  print("Error decoding JSON: \(error)")
						 }
					} else if let error = error {
						 print("Error making network request: \(error)")
					}
			  }
		 }.resume()
	}
#endif
}

struct Meal: Decodable {
	 let id: String
	 let meal: MealDetail

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case meal
	}
}

struct MealDetail: Decodable {
	 let day: Date
	 let menu: String
	 let likeDevice: [String]
}

struct ResponseModel: Decodable {
	 let success: Bool
	 let message: String
}
