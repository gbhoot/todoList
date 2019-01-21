//
//  DataService.swift
//  todoListApp
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    
    static let instance = DataService()
    
    private var missions = [Mission]()
    
    func addNewMission(withTitle: String, notes: String, andDueDate: String) {
        self.save(create: true, mTitle: withTitle, mDate: andDueDate, mNotes: notes) { (success) in
            if success {
                print("Created and saved")
            }
        }
    }
    
    func getMission(index: Int) -> Mission {
        return missions[index]
    }
    
    func updateMission(index: Int) {
        let mish = missions[index]
        if !mish.completed {
            mish.completed = true
            save(create: false, mTitle: nil, mDate: nil, mNotes: nil) { (success) in
                print("Updated and saved")
            }
        } else {
            print("Already completed")
        }
    }
    
    func editMission(index: Int, title: String, notes: String, dueDate: String) {
        let mission = missions[index]
        mission.title = title
        mission.notes = notes
        mission.dueDate = dueDate
        self.save(create: false, mTitle: nil, mDate: nil, mNotes: nil) { (success) in
            if success {
                print("Edited and saved")
            }
        }
    }
    
    func removeMission(index: Int) {
        delete(index: index) { (success) in
            if success {
                print("Removed and saved")
            }
        }
    }
    
    func returnMissions() -> [Mission] {
        fetchCoreDataObjects()
        
        return missions
    }
    
    func delete(index: Int, completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(missions[index])
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func save(create: Bool, mTitle: String?, mDate: String?, mNotes: String?, completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        if create {
            guard let title = mTitle, let date = mDate, let notes = mNotes else { return }
            let mission = Mission(context: managedContext)
            
            mission.title = title
            mission.dueDate = date
            mission.notes = notes
        }
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (success) in
            if success {
                print("Successfully fetched data")
            }
        }
    }
    
    func fetch(completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Mission>(entityName: "Mission")
        
        do {
            missions = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
