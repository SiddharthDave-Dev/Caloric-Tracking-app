//
//  CDDataModel.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import Foundation
import CoreData

class CDDataModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var saveBreakfastEntity: [BreakfastEntity] = []
    @Published var saveLunchEntity: [LunchEntity] = []
    @Published var saveValueEntity: [ValueEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CDfoodclass")
        container.loadPersistentStores{(descrip, error) in
            if let error = error {
                print("Error loading data : \(error)")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let requestone = NSFetchRequest<BreakfastEntity>(entityName: "BreakfastEntity")
        let requestTwo = NSFetchRequest<LunchEntity >(entityName: "LunchEntity")
        let requesThree = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            saveBreakfastEntity = try container.viewContext.fetch(requestone)
            saveLunchEntity = try container.viewContext.fetch(requestTwo)
            saveValueEntity = try container.viewContext.fetch(requesThree)
        } catch let error {
            print("Error fetching data : \(error)")
            
        }
    }
    
    func addBreakfast(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat){
        let newmeal = BreakfastEntity(context: container.viewContext)
        newmeal.icon = icon
        newmeal.name = name
        newmeal.ingredients = ingredients
        newmeal.fat = Float(fat)
        newmeal.protein = Float(protein)
        newmeal.cards = Float(cards)
        
        saveData()
        
    }
    
    func addLunch(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat){
        let newmeal = BreakfastEntity(context: container.viewContext)
        newmeal.icon = icon
        newmeal.name = name
        newmeal.ingredients = ingredients
        newmeal.fat = Float(fat)
        newmeal.protein = Float(protein)
        newmeal.cards = Float(cards)
        
        saveData()
        
    }
    
    func addValue(fat:CGFloat,protein: CGFloat, cards: CGFloat) {
        
        let newvalue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            let results = try container.viewContext.fetch(newvalue)
            
            if let entity = results.first {
                entity.fat += Float(fat)
                entity.protein += Float(protein)
                entity.cards += Float(cards)
            } else {
                let newvalue = ValueEntity(context: container.viewContext)
                newvalue.fat = Float(fat)
                newvalue.protein = Float(protein)
                newvalue.cards = Float(cards)
            }
            saveData()
            fetchData()
        } catch {
            print("\(error)")
        }
    }
    
    func Addringcarlories(carlories: CGFloat) {
        let newcal = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            let results = try container.viewContext.fetch(newcal)
            
            if let entity = results.first {
                entity.ring += Float(Int(carlories))
            } else {
                let newEntity = ValueEntity(context: container.viewContext)
                newEntity.ring = 10 
            }
        } catch {
            print("\(error)")
        }
        saveData()
        fetchData()
        
    }
    
    func addmealToggleforBreakfast(meal: BreakfastEntity) {
        meal.addmale.toggle()
        saveData()
    }
    
    func addmealToggleForLunch(meal: LunchEntity) {
        meal.addmale.toggle()
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            print("Save data failed : \(error)")
        }
    }
}
