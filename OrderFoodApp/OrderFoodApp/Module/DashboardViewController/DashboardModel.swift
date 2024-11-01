//
//  DashboardModel.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 02/10/24.
//

import UIKit

enum FoodCategory: String, CaseIterable {
    case pizza
    case burger
    case sausage
    case drink
    
    func setImage() -> String {
        switch self {
        case .pizza:
            return "pizzacheese"
        case .burger:
            return "burger"
        case .sausage:
            return "beefSausage"
        case .drink:
            return "drink"
        }
    }
}

struct FoodItem: Hashable {
    let name: String
    let description: String
    let image: String
    let rating: Double
    let isFavorite: Bool
    let price: Double
}

struct FoodCategoryData {
    let category: FoodCategory
    let items: [FoodItem]
}

let foodData: [FoodCategoryData] = [
    FoodCategoryData(category: .pizza,
                     items: [
                        FoodItem(name: "Pepperoni Pizza", description: "Classic pepperoni pizza", image: "pizzapeperoni", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Cheese Pizza", description: "Extra Cheese", image: "pizzacheese", rating: 4.7, isFavorite: true, price: 12500)]),
    
    FoodCategoryData(category: .burger,
                     items: [
                        FoodItem(name: "Cheese Burger", description: "Classic pepperoni pizza", image: "cheeseBurger", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Beef Burger", description: "Extra Cheese", image: "burger", rating: 4.7, isFavorite: true, price: 12500)]),
    FoodCategoryData(category: .sausage,
                     items: [
                        FoodItem(name: "Cheese Sausage", description: "Classic Cheese Sausage", image: "cheeseSausage", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Beef Sausage", description: "Extra Cheese", image: "beefSausage", rating: 4.7, isFavorite: true, price: 12500)]),
    FoodCategoryData(category: .drink,
                     items: [
                        FoodItem(name: "Mineral Water", description: "Water", image: "mineralWater", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Soft Drink", description: "Soft Drink", image: "softDrink", rating: 4.7, isFavorite: true, price: 12500)])
]





struct AdsFoodData {
    let name: String
    let image: String
    let url: String
}

let adsData: [AdsFoodData] = [
AdsFoodData(name: "Juicy Burger", image: "ads1", url: ""),
AdsFoodData(name: "Meaty Pizza", image: "ads2", url: ""),
AdsFoodData(name: "Full Package", image: "ads3", url: "")
]
