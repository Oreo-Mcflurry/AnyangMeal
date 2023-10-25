//
//  ContentView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/15.
//

import SwiftUI
import SwiftSoup
import CoreData

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var coreDataManager = CoredataManager()
    var body: some View {
      List {
          if viewModel.meals.isEmpty {
                Text("학식 정보가 없습니다.\n이번주가 휴무 이거나,\n방학일 가능성이 있습니다.\n\n\n그것도 아니라면\n개발자가 열심히 작업중입니다.")
                    .multilineTextAlignment(.center)
                    .font(.title)
            } else {

                  ForEach(viewModel.meals, id: \.self) { item in
                        Section {
                          Text(item.date ?? Date(), formatter: viewModel.dateFormatter)
                                .foregroundStyle(.secondary)
                            Text(item.meal ?? "정보없음")
                        }
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    InfoView()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .onAppear {
          viewModel.onFetch()
        }
        .navigationTitle("아냥식")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
           MainView()
        }
    }
}
