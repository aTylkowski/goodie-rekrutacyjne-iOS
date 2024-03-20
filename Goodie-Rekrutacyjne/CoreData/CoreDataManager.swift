//
//  CoreDataManager.swift
//  Goodie-Rekrutacyjne
//
//  Created by Aleksy Tylkowski on 19/03/2024.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { _, error in
            if let nsError = error as NSError? {
                fatalError("❌ Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("❌ Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func deleteEntity(index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)

            guard index >= 0 && index < entities.count else {
                print("❌ Error: Index out of bounds")
                return
            }

            let entityToDelete = entities[index]
            context.delete(entityToDelete)

            saveContext()
        } catch {
            print("❌ Error deleting entity: \(error)")
        }
    }

    func fetchEntities() -> [ProductEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities
        } catch {
            print("❌ Error fetching entities: \(error)")
            return []
        }
    }
}
