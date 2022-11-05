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
    
    static var shared = CoreDataServices()
    
    lazy var persistentContainer : NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: coreTextual.coreDataName.coreText)
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveCore(id : Int) {
        let movie = ForMovieDatabase(context: moc)
        movie.setValue(id, forKey: coreTextual.id.coreText)
        do{
            try moc.save()
            
        }catch{
            print(error)
        }
    }
    
    func completionCoreData() -> [Int] {
        do{
            let fetchRequest = NSFetchRequest<ForMovieDatabase>(entityName: movieEntity)
            let forMovie = try moc.fetch(fetchRequest)
            var idService = [Int]()
            forMovie.forEach {
                idService.append(Int($0.id))
            }
            return idService
        } catch {
            return []
        }
    }
    
    func checkFavorites(id : Int) -> Bool{
        var bool = false
        do {
            let fetchRequest = NSFetchRequest<ForMovieDatabase>(entityName: movieEntity)
            let forMovie = try moc.fetch(fetchRequest)
            forMovie.forEach {
                if id == $0.id {
                    bool = true
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return bool
    }
    
    func removeFavorites(id : Int) {
        do {
            let fetchRequest = NSFetchRequest<ForMovieDatabase>(entityName: movieEntity)
            let forMovie = try moc.fetch(fetchRequest)
            forMovie.forEach {
                if id == $0.id {
                    moc.delete($0)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveJSON(binaryData : Data) {
        let json = JsonDatabase(context: moc)
        json.setValue(binaryData, forKey: coreTextual.currentJSON.coreText)
        do{
            try moc.save()
            usDef.setValue(true, forKey: usDefTextual.sourceControl.usDefText)
        }catch{
            print(error)
        }
    }
    
    func deleteJson() {
        do {
            let fetchRequest = NSFetchRequest<JsonDatabase>(entityName: jsonEntity)
            let json = try moc.fetch(fetchRequest)
            json.forEach {
                moc.delete($0)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getJson(completion : @escaping(Swift.Result<[MovieResultModel],Error>) -> (Void)) {
        do {
            let fethRequest = NSFetchRequest<JsonDatabase>(entityName: jsonEntity)
            let json = try moc.fetch(fethRequest)
            json.forEach {
                if $0.currentJSON != nil {
                    do {
                        let parsingData = try JSONDecoder().decode(MovieModel.self, from: $0.currentJSON!)
                        completion(.success(parsingData.results))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
