//
//  AppSettings.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import Foundation
import UIKit

enum SFSymbols {
    static let dashboardSymbol = UIImage(systemName: "house.fill")
    static let chartSymbol = UIImage(systemName: "chart.bar.doc.horizontal")
    static let historySymbol = UIImage(systemName: "clock.fill")
    static let profilSymbol = UIImage(systemName: "person.fill")
    
    static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
}


class AppSettings {
    static let shared = AppSettings()
    private let userDefaults = UserDefaults.standard
    
    private init () {}
    
    func saveStringValue(_ value: String, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func getStringValue (forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    var isFirstTime: Bool {
        get {
            return userDefaults.value(forKey: UserDefaultsKey.isFirstTime) as? Bool ?? true
        }
        set(_isNewDevice) {
            userDefaults.set(_isNewDevice, forKey: UserDefaultsKey.isFirstTime)
            userDefaults.synchronize()
        }
    }
}


class UserDefaultsKey {
    static let isFirstTime = "IsFirstTime"
}
