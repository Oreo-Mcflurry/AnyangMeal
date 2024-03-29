//
//  InfoView.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/16.
//

import SwiftUI

struct InfoView: View {
  var body: some View {
    List {
      Section {
        Text("학식 : ₩5,000\n우동 : ₩3000\n라면 : ₩3,000\n치즈, 떡라면 : ₩3,500\n떡+치즈라면 : ₩4,000")
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
    }
  }
}
