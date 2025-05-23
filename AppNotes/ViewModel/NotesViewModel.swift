//
//  NotesViewModel.swift
//  AppNotes
//
//  Created by Tran Cao Thang on 15/02/2025.
//

import Foundation
import CoreData

class NotesViewModel: ObservableObject {

    let manager: CoreDataManager
    @Published var notes: [Entity] = []
    @Published var isDataLoaded = false

    init(manager: CoreDataManager) {
        self.manager = manager
        loadData()
    }
    
    func loadData() {
        manager.loadCoreData { [weak self] result in
            DispatchQueue.main.async {
                self?.isDataLoaded = result
                if result {
                    self?.fetchNotes()
                }
            }
        }
    }

    func fetchNotes(with searchText: String = "")  {
            let request: NSFetchRequest<Entity> = Entity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
            
            if !searchText.isEmpty {
                request.predicate = NSPredicate(format: "title CONTAINS %@", searchText)
            }

            do {
                notes = try manager.container.viewContext.fetch(request)
            } catch {
                print("Error fetching notes: \(error)")
            }
        }

        func createNote() -> Entity {
            let newNote = Entity(context: manager.container.viewContext)
            newNote.id = UUID()
            newNote.timestamp = Date()
            saveContext()
            fetchNotes() // Refresh notes list

            return newNote
                }

                func deleteNote(_ note: Entity) {
                    manager.container.viewContext.delete(note)
                    saveContext()
                    fetchNotes() // Refresh notes list
                }

                func updateNote(_ note: Entity, title: String, content: String) {
                    note.title = title
                    note.content = content
                    saveContext()
                    fetchNotes() // Refresh notes list
                }
                
                func searchNotes(with searchText: String) {
                    fetchNotes(with: searchText)
                }

                private func saveContext() {
                    do {
                        try manager.container.viewContext.save()
                    } catch {
                        print("Error saving context: \(error)")
                    }
                }
            }
