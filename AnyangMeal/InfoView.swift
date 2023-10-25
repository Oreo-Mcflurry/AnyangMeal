//
//  InfoView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/16.
//

import SwiftUI

struct InfoView: View {
    @State private var showAlert = false
    var contentView = ContentView()
    let coreDataManager = CoredataManager()
    var body: some View {
        List {
            Section {
                Text("학식 : ₩5,000\n라면 : ₩3,000\n치즈, 떡라면 : ₩3,500\n떡+치즈라면 : ₩4,000")
            } header: {
                Text("가격")
            }
            
            Section {
                Text("중식 11:00 ~ 15:00")
                Text("석식 15:30 ~ 18:00")
            } header: {
                Text("학식 시간")
            }
            
            Section {
                Text("라면은 아침 9시부터 판매합니다.")
                Text("금요일은 석식이 없습니다.")
                Text("방학 중에는 운영하지 않습니다.")
            } header: {
                Text("안내사항")
            }
            
            Section {
                Text("20학번 소프트웨어 화이팅")
            } header: {
                Text("개발자의 한마디")
            }
            
            Section {
                Button("학식 정보 리셋하기") {
                    contentView.onFetch()
                    showAlert = true
                }
                .foregroundColor(.red)
            } header: {
                Text("학식 정보가 이상해요")
            }
            
        }
        .alert(isPresented: $showAlert) {
                    // 알림 내용을 정의합니다.
                    Alert(
                        title: Text("학식 정보 리셋을 완료하였습니다."),
                        dismissButton: .default(Text("확인")) {
                            showAlert = false
                        }
                    )
                }
    }
    func createSampleMeals() {
        let context = coreDataManager.container.viewContext
        
        let currentDate = Date()
        let calendar = Calendar.current
        let mealNames = ["Breakfast", "Lunch", "Dinner"]
        
        for dayOffset in 0..<5 {
            let date = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            
            for mealName in mealNames {
                let meal = Meal(context: context)
                meal.date = date
                meal.meal = mealName
            }
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
