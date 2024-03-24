//
//  ContentView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/15.
//

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = ViewModel()

	var body: some View {
		mainView
			.navigationTitle("아냥식")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) { infoNavigation }
			}
	}

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

	@ViewBuilder
	private var infoNavigation: some View {
		NavigationLink {
			InfoView()
		} label: {
			Image(systemName: "info.circle")
		}
	}

	private var mealloadView: some View {
		Text("학식 정보가 없습니다.")
			.multilineTextAlignment(.center)
			.font(.title)
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

	private var mealView: some View {
		List {
			if let data = viewModel.meals?.data {
				ForEach(data.indices, id: \.self) { index in
					MealView(meal: data[index])
				}
			}
		}
	}
}

struct MealView: View {
	@Environment(\.colorScheme) var colorScheme
	@StateObject var viewModel = ViewModel()
	let meal: Meal

	var body: some View {
		Section {
			Text(meal.meal.day, formatter: DateFormatter.formatDate)
				.foregroundStyle(.secondary)
			Text(meal.meal.menu)
				.lineSpacing(5)

			Button {
				if viewModel.isLiked(meal) {
					viewModel.callRequest(.cancelLike(id: meal.id))
				} else {
					viewModel.callRequest(.like(id: meal.id))
				}
			} label: {
				HStack {
//					Image(systemName: meal.likeDevice.contains(viewModel.getDeviceID()) ? "hand.thumbsup.fill" : "hand.thumbsup")
					Text("\(meal.meal.likeDevice.count)")
				}
				.foregroundStyle(colorScheme == .dark ? .white : .black)
			}
		}
	}
}
