//
//  APIRequestManager.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 3/4/24.
//

import Foundation
import Alamofire

class APIRequestManager {
	enum APICallError: Error {
		case serverError
	}

	func callRequest<T: Decodable>(_ type: T.Type, api: APIURLs, _ completionHandler: @escaping (T?, APICallError?)->Void) {
		AF.request(api.getURL, method: api.getMethod, parameters: api.parameter).responseDecodable(of: T.self) { response in
			switch response.result {
			case .success(let success):
				 completionHandler(success, nil)
			case .failure(_):
				completionHandler(nil, .serverError)
			}
		}
	}
}
