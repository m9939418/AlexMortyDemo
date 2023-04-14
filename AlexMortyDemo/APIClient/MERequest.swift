//
//  Request.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import Foundation
import UIKit

final class MERequest{
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
        
        return string
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
    
    convenience init?(url: URL) {
        let string = url.absoluteString /// https://rickandmortyapi.com/api/character?page=2
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        /// https://rickandmortyapi.com/api/ -> 空字串
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")    /// trimmed -> character?page=2
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let meEndpoint = EndPoint(rawValue: endPointString) {
                    self.init(endPoint: meEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")   /// character?page=2
            if !components.isEmpty, components.count >= 2 {
                let endPointString = components[0]  /// character
                let queryItemsString = components[1]    /// page=2
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    /// $0 -> page=2
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0], /// page
                        value: parts[1] /// 2
                    )
                })
                
                if let meEndpoint = EndPoint(rawValue: endPointString) {
                    self.init(endPoint: meEndpoint, queryParam: queryItems)
                    return
                }
            }
        }
        return nil
    }

}

extension MERequest {
    static let listCharactersRequests = MERequest(endPoint: .character)
}
