//
//  coreDataManager.swift
//  TakeNotes
//
//  Created by MacOS on 22/09/2025.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    // Singleton instance
    static let shared = CoreDataManager()
    let context: NSManagedObjectContext
    
    private init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    func fetchNotes(filter: String? = nil) -> [Notes] {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        
        if let filter = filter {
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR body CONTAINS[cd] %@", filter, filter)
        }
        let timeSort = NSSortDescriptor(key: "time", ascending: false)
        let pinnedSort = NSSortDescriptor(key: "isPinned", ascending: false)
        
        request.sortDescriptors = [pinnedSort, timeSort]
        do {
            return try context.fetch(request)
        } catch {
            print("Error Fetching Data From Context XXXXXXXXXXX \(error)")
            return []
        }
    }
    
    func addNote(title: String, body: String) {
        
        let newNote = Notes(context: context)
        newNote.title = title
        newNote.body = body
        newNote.time = Date()
        
        saveContext()
    }
    
    func updateNote(_ note: Notes,title: String, body: String) {
        note.title = title
        note.body = body
        note.time = Date()
        
        saveContext()
    }
    
    func deleteNode(array notesArray: Array<Notes>, at indexPath: IndexPath) {
        context.delete(notesArray[indexPath.row])
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error Saving Context XXXXXXXXXXX \(error)")
        }
        
    }
    
}
