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
	var body: some Scene {
		WindowGroup {
			NavigationView {
				MainView()
			}
			.navigationViewStyle(StackNavigationViewStyle())
		}
	}
}
