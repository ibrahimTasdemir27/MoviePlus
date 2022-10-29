//
//  CoreDataServices.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit
import CoreData
import SwiftyJSON

class CoreDataServices{
    
    let jsonEntity = coreTextual.jsonEntity.coreText
    let movieEntity = coreTextual.movieEntity.coreText
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  fetchService = NSFetchRequest<NSFetchRequestResult>(entityName: movieEntity)
    
    func saveCore(id : Int) {
        let context = appDelegate.persistentContainer.viewContext
        let onService = NSEntityDescription.insertNewObject(forEntityName: movieEntity, into: context)
        onService.setValue(id, forKey: coreTextual.id.coreText)
        do{
            try context.save()
            
        }catch{
            print(error)
        }
    }
    
    func completionCoreData() -> [Int] {
        let context = appDelegate.persistentContainer.viewContext
        var idService = [Int]()
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject]{
                if let id = result.value(forKey: coreTextual.id.coreText) as? Int {
                    idService.append(id)
                }
            }
            return idService
        }catch{
            print(error)
        }
        return []
    }
    
    func checkFavorites(id : Int) -> Bool{
        let context = appDelegate.persistentContainer.viewContext
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject]{
                if id == result.value(forKey: coreTextual.id.coreText) as? Int{
                    return true
                }
            }
        }catch{
            print(error)
        }
        return false
    }
    
    func removeFavorites(id : Int) {
        let context = appDelegate.persistentContainer.viewContext
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject]{
                if id == result.value(forKey: coreTextual.id.coreText) as? Int{
                    context.delete(result)
                }
            }
            try context.save()
            print("siliniyor")
        }catch{
            print(error)
        }
    }
    
    func saveJSON(binaryData : Data) {
        let context = appDelegate.persistentContainer.viewContext
        let onServices = NSEntityDescription.insertNewObject(forEntityName: jsonEntity, into: context)
        onServices.setValue(binaryData, forKey: coreTextual.currentJSON.coreText)
        do{
            try context.save()
            print("hakaydetti")
            usDef.setValue(true, forKey: usDefTextual.sourceControl.usDefText)
        }catch{
            print(error)
        }
    }
    
    func deleteJson() {
        let context = appDelegate.persistentContainer.viewContext
        let fetchService = NSFetchRequest<NSFetchRequestResult>(entityName: jsonEntity)
        fetchService.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject] {
                context.delete(result)
                print("hasildi")
            }
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func getJson(completion : @escaping(Swift.Result<[MovieResultModel],Error>) -> (Void)) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchServices = NSFetchRequest<NSFetchRequestResult>(entityName: jsonEntity)
        do{
            let results = try context.fetch(fetchServices)
            for result in results as! [NSManagedObject]{
                if let binaryData = result.value(forKey: coreTextual.currentJSON.coreText) as? Data {
                    do{
                        
                        let parsingData = try JSONDecoder().decode(MovieModel.self, from: binaryData)
                        completion(.success(parsingData.results))
                    }catch{
                        print(error)
                    }
                }
            }
        }catch{
            print(error)
        }
    }
}
