//
//  ChartModel.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import Foundation
import UIKit

struct ProfileData {
    var name: String
    var age: Int
    var status: String
}

class ChartList {
    static let shared = ChartList()
    private init() {}
    
    var dataList: [ProfileData] = []
    
    func addChart(data: ProfileData
    ) {
        dataList.append(data)
    }
    
    func editChart(idx: Int, data: ProfileData) {
        dataList[idx] = data
    }
    
    func removeChart(idx: Int) {
        dataList.remove(at: idx)
    }
}
