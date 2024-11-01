//
//  Constants.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 31/10/24.
//

import Foundation

struct Constants {
    public static var baseURL: String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
}

