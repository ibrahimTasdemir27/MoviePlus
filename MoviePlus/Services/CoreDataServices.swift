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
    lazy var context = appDelegate.persistentContainer.viewContext
    lazy var onService = NSEntityDescription.insertNewObject(forEntityName: movieEntity, into: context)
    lazy var  fetchService = NSFetchRequest<NSFetchRequestResult>(entityName: movieEntity)
    
    func saveCore(id : Int) {
        onService.setValue(id, forKey: coreTextual.id.coreText)
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func completionCoreData() -> [Int] {
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
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject]{
                if id == result.value(forKey: coreTextual.id.coreText) as? Int{
                    context.delete(result)
                }
            }
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func saveJSON(binaryData : Data) {
        let onService = NSEntityDescription.insertNewObject(forEntityName: jsonEntity, into: context)
        onService.setValue(binaryData, forKey: coreTextual.currentJSON.coreText)
        do{
            try context.save()
            usDef.setValue(true, forKey: usDefTextual.sourceControl.usDefText)
        }catch{
            print(error)
        }
    }
    
    func deleteJson() {
        let fetchService = NSFetchRequest<NSFetchRequestResult>(entityName: jsonEntity)
        fetchService.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchService)
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func getJson(completion : @escaping(Swift.Result<[MovieResultModel],Error>) -> (Void)) {
        let fetchService = NSFetchRequest<NSFetchRequestResult>(entityName: jsonEntity)
        do{
            let results = try context.fetch(fetchService)
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
