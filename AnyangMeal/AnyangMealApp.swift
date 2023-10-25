//
//  AnyangMealApp.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/15.
//

import SwiftUI
import CoreData

@main
struct AnyangMealApp: App {
    let coreDataManager = CoredataManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, coreDataManager.container.viewContext)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
