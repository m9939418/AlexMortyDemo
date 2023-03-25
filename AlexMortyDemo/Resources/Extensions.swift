//
//  Extensions.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...){
        views.forEach { view in
            addSubview(view)
        }
    }
}
