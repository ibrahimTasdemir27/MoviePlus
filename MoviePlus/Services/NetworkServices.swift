//
//  NetworkServices.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import Alamofire
import SwiftyJSON

struct APIService{
    
//    func getData(completion : @escaping((Swift.Result<[MovieResultModel],Error>) -> Void)){
//        let request = AF.request(baseUrl , method: .get)
//        request.validate().responseDecodable(of : MovieModel.self) { response in
//            switch response.result{
//            case .success(let movieResult):
//                    if usDef.bool(forKey: "sourceControl") != true{
//                    let json = JSON(movieResult)
//                    let binaryData = Data(json.debugDescription.utf8)
//                    CoreDataServices().saveJSON(binaryData: binaryData)
//                }
//                completion(.success(movieResult.results))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    func getData(completion : @escaping(Swift.Result<[MovieResultModel] , Error>) -> Void) {
        AF.request(URL(string: baseUrl)!, method: .get).validate().response{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value!)
                let binaryData = Data(json.debugDescription.utf8)
                do {
                    let res = try JSONDecoder().decode(MovieModel.self, from: binaryData)
                    completion(.success(res.results))
                    if usDef.bool(forKey: usDefTextual.sourceControl.usDefText) != true {
                        CoreDataServices().deleteJson()
                        CoreDataServices().saveJSON(binaryData: binaryData)
                    }
                } catch  {
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
