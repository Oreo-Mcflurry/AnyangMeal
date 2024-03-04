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
		 mainView
    }

	@ViewBuilder
	private var mainView: some View {
		switch viewModel.responseState {
		case .successAndEmptry:
			mealEmptyView
		case .fail:
			mealFailView
		case .success:
			successView
		}
	}

	private var mealEmptyView: some View {
		Text("학식 정보가 없습니다.")
			.multilineTextAlignment(.center)
			.font(.title)
	}

	private var mealFailView: some View {
		Text("학식 정보를 받아오는데 실패하였습니다.")
			.multilineTextAlignment(.center)
			.font(.title)
	}

	private var successView: some View {
		TabView(selection: $viewModel.currentPage) {
			ForEach(0..<viewModel.meals!.data!.count, id: \.self) { index in
				List {
					Text(viewModel.meals!.data![index].meal.day, formatter: DateFormatter.formatDate)
					Text(viewModel.meals!.data![index].meal.menu)
						.lineSpacing(4)
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
