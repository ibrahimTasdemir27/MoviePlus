//
//  NetworkServices.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import Alamofire

struct APIService{
    
    func getData(completion : @escaping((Swift.Result<[MovieResultModel],Error>) -> Void)){
        let request = AF.request(baseUrl)
        request.validate().responseDecodable(of : MovieModel.self) { response in
            switch response.result{
            case .success(let movieResult):
                completion(.success(movieResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
