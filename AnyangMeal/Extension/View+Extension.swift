//
//  View+Extension.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2/7/24.
//

import SwiftUI

extension DateFormatter {
	static var formatDate: DateFormatter {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ko_KR")
		formatter.dateFormat = "M월dd일(EEE)"
		return formatter
	}
}
