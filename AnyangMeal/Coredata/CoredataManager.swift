//
//  CoredataManager.swift
//  AnyangMeal
//
//  Created by A_Mcflurry on 2023/09/16.
//

import CoreData

class CoredataManager: ObservableObject {
    private let appGroup = "group.AnyangMealWidget"
    let container = NSPersistentContainer(name: "Meal")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func addMeal(date: Date, meal: String, context: NSManagedObjectContext) {
        let newMeal = Meal(context: context)
        newMeal.date = date
        newMeal.meal = meal
        
        save(context: context)
    }
    
    func fetchAllMeals(context: NSManagedObjectContext) -> [Meal] {
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            do {
                let meals = try context.fetch(fetchRequest)
                return meals
            } catch {
                print(error)
                return []
            }
        }

        func deleteAllMeals(context: NSManagedObjectContext) {
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            do {
                let meals = try context.fetch(fetchRequest)
                for meal in meals {
                    context.delete(meal)
                }
                save(context: context)
            } catch {
                print(error)
            }
        }
    
}
