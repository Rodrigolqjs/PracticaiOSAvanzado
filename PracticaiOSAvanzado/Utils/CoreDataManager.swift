//
//  CoreDataManager.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation
import CoreData


class CoreDataManager {

    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = NSPersistentContainer(name: "PracticaiOSAvanzado")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    func createCharacter(character: Character, completion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        
        let characterCD = CharacterCD(context: context)
        characterCD.name = character.name
        characterCD.desc = character.description
        characterCD.photo = character.photo
        characterCD.latitude = character.latitud ?? 0.000
        characterCD.longitude = character.longitude ?? 0.000
        characterCD.id = character.id
        characterCD.favorite = character.favorite
        
        do {
            try context.save()
        } catch {
            print("ocurrio un eror en el guardado de heroes \(error)")
        }
    }
    
    func fetchCharacter() -> [CharacterCD] {
        let fetchRequest: NSFetchRequest<CharacterCD> = CharacterCD.fetchRequest()
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error en fetchCharacter \(error)")
        }
        return []
    }
    
    func fetchCharacter(with predicate: NSPredicate) -> [CharacterCD] {
        let fetchRequest: NSFetchRequest<CharacterCD> = CharacterCD.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error en fetchCharacter \(error)")
        }
        return []
    }
    
    func deleteCoreData(entityName: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("Error \(error)")
        }
    }
    
}
