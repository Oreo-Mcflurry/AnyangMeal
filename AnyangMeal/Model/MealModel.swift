//
//  MealModel.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 3/4/24.
//

import Foundation

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
