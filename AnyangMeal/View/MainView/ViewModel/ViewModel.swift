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
		callRequest(.call)
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
		case load
		case successAndEmptry
		case fail
		case success
	}

	var responseState: ResponseKind {

		if meals?.data == nil && meals?.error == nil {
			return .load
		}

		if let data = meals?.data, !data.isEmpty {
			return .success
		}

		if (meals?.error) != nil {
			return .fail
		}
		
		return .successAndEmptry
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
