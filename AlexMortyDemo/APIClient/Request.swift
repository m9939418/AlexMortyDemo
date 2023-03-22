//
//  Request.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import Foundation
import UIKit

final class Reqesut{
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endPoint: EndPoint
    private let pathComponents: [String]
    private let queryParam: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if(!pathComponents.isEmpty){
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParam.isEmpty {
            string += "?"
            let args = queryParam.compactMap({
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += args
        }
        
        return ""
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    
    
    public init(
        endPoint: EndPoint,
        pathComponents: [String] = [],
        queryParam: [URLQueryItem] = []
    ){
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParam = queryParam
    }
}
