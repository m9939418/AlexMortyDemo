//
//  RMSearchViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/22.
//

import UIKit

/// Configuration controller to search
final class RMSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unspported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "搜尋"
        view.backgroundColor = .systemPink
    }

}
