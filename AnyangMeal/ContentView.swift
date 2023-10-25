//
//  ContentView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/15.
//

import SwiftUI
import SwiftSoup
import CoreData

struct ContentView: View {
    let urlString = "https://www.anyang.ac.kr/main/activities/school-cafeteria.do"
    @State private var meals: [Meal] = []
    @StateObject var coreDataManager = CoredataManager()
    let dateformatter: DateFormatter
    
    init() {
        dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.dateFormat =  "M월dd일(EEE)"
    }
    
    var body: some View {
        Group {
            if meals.isEmpty {
                Text("학식 정보가 없습니다.\n이번주가 휴무 이거나,\n방학일 가능성이 있습니다.\n\n\n그것도 아니라면\n개발자가 열심히 작업중입니다.")
                    .multilineTextAlignment(.center)
                    .font(.title)
            } else {
                List {
                    ForEach(meals, id: \.self) { item in
                        Section {
                            Text(item.date ?? Date(), formatter: dateformatter)
                                .foregroundStyle(.secondary)
                            Text(item.meal ?? "정보없음")
                        }
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
            let context = coreDataManager.container.viewContext
            meals = coreDataManager.fetchAllMeals(context: context)
            let calendar = Calendar.current
            let currentDate = Date()
            if let lastDate = meals.last?.date {
                // lastDate에 2일을 추가
                if let updatedDate = calendar.date(byAdding: .day, value: 2, to: lastDate) {
                    if updatedDate < currentDate {
                        print("Fetch")
                        print(updatedDate)
                        print(currentDate)
                        onFetch()
                    }
                }
            } else {
                print("Fetch")
                onFetch()
            }
        }
        .navigationTitle("아냥식")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func onFetch() {
        let context = coreDataManager.container.viewContext
        coreDataManager.deleteAllMeals(context: context)
        fetchMeal()
        meals = coreDataManager.fetchAllMeals(context: context)
    }
    
    func fetchMeal() {
        if let url = URL(string: urlString) {
            do {
                let webString = try String(contentsOf: url)
                let document = try SwiftSoup.parse(webString)
                
                // 원하는 부분 선택 try
              if let inputElement = try document.select("input#mealList").last() {
                    let value = try inputElement.attr("value")

                    let cleanedValue = value
                        .replacingOccurrences(of: "[", with: "")
                        .replacingOccurrences(of: "]", with: "")
                        .replacingOccurrences(of: "{", with: "")
                        .replacingOccurrences(of: "}", with: "")
                        .replacingOccurrences(of: "\"", with: "")
                        .replacingOccurrences(of: "\\", with: "")
                        .replacingOccurrences(of: ":", with: "")
                        .replacingOccurrences(of: ",", with: "\n")
                        .replacingOccurrences(of: " ", with: "")
                        .replacingOccurrences(of: "monMain02", with: "")
                        .replacingOccurrences(of: "monSub02", with: "")
                        .replacingOccurrences(of: "tueSub02", with: "")
                        .replacingOccurrences(of: "wedSub02", with: "")
                        .replacingOccurrences(of: "thuSub02", with: "")
                        .replacingOccurrences(of: "friSub02", with: "")
                    let context = coreDataManager.container.viewContext
                    let keywords = ["tueMain02", "wedMain02", "thuMain02", "friMain02"]
                    var dayMeals = keywords.reduce([cleanedValue]) { result, keyword in
                        return result.flatMap { $0.components(separatedBy: keyword) }
                    }
                print(dayMeals)
                    // 문자열 배열의 마지막 문자열을 가져옵니다.

                    for i in 0..<dayMeals.count {
                        if dayMeals[i].last == "\n" {
                            dayMeals[i].removeLast()
                        }
                    }
                    let dates = getThisWeekDates()

                  let count = min(dayMeals.count, dates.count)
                
                    for i in 0..<count {
                        coreDataManager.addMeal(date: dates[i], meal: dayMeals[i], context: context)
                    }
                    
                }
            } catch {
                print("에러 발생: \(error.localizedDescription)")
            }
        }
    }
    func getThisWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // 월요일을 첫 번째 요일로 설정
        var currentDate = Date()
        
        // 이번 주의 시작 날짜 계산
        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        
        // 이번 주의 끝 날짜 계산
        let endDate = calendar.date(byAdding: .day, value: 6, to: startDate)!
        
        // 이번 주의 날짜 목록 생성
        var dates: [Date] = []
        currentDate = startDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "YYYY-MM-dd" // "9월15일(금)" 형식 M월dd일(EEE)
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            
        }
        
        return dates
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
