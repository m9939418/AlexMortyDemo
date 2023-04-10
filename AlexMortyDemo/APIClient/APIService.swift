//
//  APIService.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init(){
        
    }
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ reqeust: MERequest,
                                    excepting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void){
        guard let urlRequest = self.request(from: reqeust) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        print("API Call: \(reqeust.url?.absoluteString)")
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data)
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    private func request(from request: MERequest) -> URLRequest?{
        guard let url = request.url else {
            return nil
        }
        var _request = URLRequest(url: url)
        _request.httpMethod = request.httpMethod
        return _request
    }
}
