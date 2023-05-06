//
//  APICacheManager.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/25.
//

import Foundation

final class APICacheManager {
    
    private var cacheDictionary: [
        EndPoint: NSCache<NSString, NSData>
    ] = [:]

    init() {
        setUpCache()
    }
    
    
    //MARK: - Public
    public func cacheResponse(for endPoint: EndPoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endPoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endPoint: EndPoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endPoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    
    //MARK: - Private
    private func setUpCache() {
        EndPoint.allCases.forEach { endPoint in
            cacheDictionary[endPoint] = NSCache<NSString, NSData>()
        }
    }
    
    
    
}
