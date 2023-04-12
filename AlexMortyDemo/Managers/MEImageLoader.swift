//
//  MEImageLoader.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/12.
//

import Foundation

/// 圖片 Manager
final class MEImageLoader {
    static let shared = MEImageLoader()
    
    private var imageCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(_ url: URL, completeion: @escaping (Result<Data, Error>)-> Void) {
        let key = url.absoluteString as NSString
        if let data = imageCache.object(forKey: key) {
            completeion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completeion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageCache.setObject(value, forKey: key)
            completeion(.success(data))
        }
        task.resume()
    }
}
