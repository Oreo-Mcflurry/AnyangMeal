//
//  ContentView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/15.
//

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = ViewModel()
	@Environment(\.colorScheme) var colorScheme
	var body: some View {
		mainView
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink {
						InfoView()
					} label: {
						Image(systemName: "info.circle")
					}
				}
			}
			.navigationTitle("아냥식")
			.navigationBarTitleDisplayMode(.inline)
	}

	@ViewBuilder
	private var mainView: some View {
		if viewModel.meals.isEmpty {
			Text("학식 정보가 없습니다.\n이번주가 휴무 이거나,\n방학일 가능성이 있습니다.\n\n\n그것도 아니라면\n개발자가 열심히 작업중입니다.")
				.multilineTextAlignment(.center)
				.font(.title)
		} else {
			List {
				ForEach(0..<viewModel.meals.count, id: \.self) { index in
					Section {

						Text(viewModel.meals[index].meal.day, formatter: viewModel.dateFormatter)
							.foregroundStyle(.secondary)
						Text(viewModel.meals[index].meal.menu)
							.lineSpacing(5)

						Button {
							if viewModel.meals[index].meal.likeDevice.contains(viewModel.getDeviceID()) {
								viewModel.removeDeviceFromMealLike(_id: viewModel.meals[index].id)
							} else {
								viewModel.addDeviceToMealLike(_id: viewModel.meals[index].id)
							}
						} label: {
							HStack {
								Image(systemName: viewModel.meals[index].meal.likeDevice.contains(viewModel.getDeviceID()) ? "hand.thumbsup.fill" : "hand.thumbsup")
								Text("\(viewModel.meals[index].meal.likeDevice.count)")
							}
							.foregroundStyle(colorScheme == .dark ? .white : .black)

						}

					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
           MainView()
        }
    }
}
