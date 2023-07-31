//
//  RMSettingsCellViewModel.swift
//  AlexMortyDemo
//
//  Created by Alex YANG 楊明仁 on 2023/6/30.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    let id = UUID()
    
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    // MARK: - Init
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    
    //MARK: - Public
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerCcolor
    }
}
