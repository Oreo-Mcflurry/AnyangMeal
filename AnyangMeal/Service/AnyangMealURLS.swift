//
//  AnyangMealURLS.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2/7/24.
//

import UIKit
import Alamofire

enum APIURLs {
	case call
	case like(id: String)
	case cancelLike(id: String)

	var getURL: URL {
		switch self {
		case .call: return URL(string: "https://anyang-api.fly.dev/getMeals")!
		case .like: return URL(string: "https://anyang-api.fly.dev/addDeviceToMealLike")!
		case .cancelLike: return URL(string: "https://anyang-api.fly.dev/removeDeviceFromMealLike")!
		}
	}

#if os(iOS)
	private var deviceID: String {
		return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
	}
#endif

	var getMethod: HTTPMethod {
		switch self {
		case .call: return .get
		case .like: return .post
		case .cancelLike: return .delete
		}
	}

	var parameter: Parameters {
		switch self {
		case .call:
			return [:]
#if os(iOS)
		case .cancelLike(let id), .like(let id):
			return  ["_id": id, "deviceId": deviceID]
#elseif os(watchOS)
		case .cancelLike(let id), .like(let id):
			return  ["_id": id, "deviceId": "null"]
#endif
		}
	}

	var type: Decodable.Type {
		switch self {
		case .call:
		 return [Meal].self
		case .like, .cancelLike:
			return ResponseModel.self
		}
	}
}

