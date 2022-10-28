//
//  CoreDataServices.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit
import CoreData

class CoreDataServices{
    
    let entityName = "DataBase"
    
    func saveService(dict : MovieResultModel ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let onService = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        onService.setValue(dict.id, forKey: "id")
        onService.setValue(dict.original_title, forKey: "title")
        onService.setValue(dict.overview, forKey: "overview")
        onService.setValue(imagaBaseUrl + dict.poster_path,forKey: "imageurl")
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
    
    func removeFavorite(id : Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let onService = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        onService.predicate = NSPredicate(format: "id = %d",id)
        onService.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(onService)
            
            for result in results as! [NSManagedObject] {
                if let movieID = result.value(forKey: "id") as? Int{
                    if movieID == id {
                        context.delete(result)
                        do {
                            try context.save()
                            return true
                        }catch{
                            print(error)
                        }
                    }
                }
            }
        }catch{
            
        }
        return false
    }
    
    func checkFavorite(id : Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let onService = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        onService.predicate = NSPredicate(format: "id = %d",id)
        onService.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(onService)
            
            for result in results as! [NSManagedObject] {
                if let movieID = result.value(forKey: "id") as? Int{
                  return true
                }else {
                    return false
                }
            }
        }catch{
            
        }
        return false
    }
    
    
}
