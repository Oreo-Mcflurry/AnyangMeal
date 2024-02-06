//
//  ContentView.swift
//  AnyangMealWatch Watch App
//
//  Created by A_Mcflurry on 12/13/23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel = ViewModel()
    var body: some View {
		 TabView(selection: $viewModel.currentPage) {
			 ForEach(0..<viewModel.meals.count, id: \.self) { index in
				 List {
					 Text(viewModel.meals[index].meal.day, formatter: viewModel.dateFormatter)
					 Text(viewModel.meals[index].meal.menu)
						 .lineSpacing(4)
				 }
			 }
		 }
    }
}

#Preview {
    ContentView()
}

//if viewModel.meals.isEmpty {
//	Text("학식 정보가 없습니다.\n이번주가 휴무 이거나,\n방학일 가능성이 있습니다.\n\n\n그것도 아니라면\n개발자가 열심히 작업중입니다.")
//		.multilineTextAlignment(.center)
//} else {
//	ForEach(0..<viewModel.meals.count, id: \.self) { index in
//		Section {
//			Text(viewModel.meals[index].meal.day, formatter: viewModel.dateFormatter)
//			Text(viewModel.meals[index].meal.menu)
//		}
//	}
// }
