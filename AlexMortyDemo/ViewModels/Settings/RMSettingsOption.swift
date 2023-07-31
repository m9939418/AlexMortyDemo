//
//  RMSettingsOption.swift
//  AlexMortyDemo
//
//  Created by Alex YANG 楊明仁 on 2023/6/30.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://buzzorange.com/techorange/2021/06/08/ai-text2app-android-development/")
        case .terms:
            return URL(string: "https://ithelp.ithome.com.tw/articles/10261382")
        case .privacy:
            return URL(string: "https://tw.news.yahoo.com/vtuber%E5%A0%B1%E6%96%B0%E8%81%9E-%E8%95%8A%E7%B1%B3remi-%E5%94%B1%E5%8A%9F%E4%BA%86%E5%BE%97-%E7%B6%B2%E5%8F%8B%E7%B4%9B%E5%96%8A-%E6%88%80%E6%84%9B%E4%BA%86-094012323.html")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewSeries:
            return URL(string: "https://tw.news.yahoo.com/topic/legislature-live/")
        case .viewCode:
            return URL(string: "https://tw.stock.yahoo.com/fund/")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact us"
        case .terms:
            return "Terms of Services"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerCcolor: UIColor {
        switch self {
        case .rateApp:
            return .systemGreen
        case .contactUs:
            return .systemRed
        case .terms:
            return .systemYellow
        case .privacy:
            return .systemTeal
        case .apiReference:
            return .systemOrange
        case .viewSeries:
            return .systemPink
        case .viewCode:
            return .systemGray
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
