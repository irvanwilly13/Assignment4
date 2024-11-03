//
//  DashboardModel.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 02/10/24.
//

import Foundation
import UIKit

enum FoodCategory: String, CaseIterable, Codable {
    case spagethi
    case lasagna
    case pizza
    case drink
    
    
    func setImage() -> String {
        switch self {
        case .spagethi:
            return "spagethi1"
        case .lasagna:
            return "lasagna1"
        case .pizza:
            return "pizza1"
        case .drink:
            return "drink1"
        }
    }
}

struct FoodItem: Hashable, Codable {
    let name: String
    let description: String
    let image: String
    let rating: Double
    let isFavorite: Bool
    let price: Double
}

struct FoodModel: Codable {
    let foodData: [FoodCategoryData]
    let promoData: [PromotionFoodData]
    let adsData: [AdsFoodData]
}

struct FoodCategoryData: Codable {
    let category: FoodCategory
    let items: [FoodItem]
}

let foodData: [FoodCategoryData] = [
    FoodCategoryData(category: .spagethi,
                     items: [
                        FoodItem(name: "Pepperoni Pizza", description: "Classic pepperoni pizza", image: "spagethi1", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Cheese Pizza", description: "Extra Cheese", image: "spagethi2", rating: 4.7, isFavorite: true, price: 12500)]),
    
    FoodCategoryData(category: .lasagna,
                     items: [
                        FoodItem(name: "Cheese Burger", description: "Classic pepperoni pizza", image: "cheeseBurger", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Beef Burger", description: "Extra Cheese", image: "burger", rating: 4.7, isFavorite: true, price: 12500)]),
    FoodCategoryData(category: .pizza,
                     items: [
                        FoodItem(name: "Cheese Sausage", description: "Classic Cheese Sausage", image: "cheeseSausage", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Beef Sausage", description: "Extra Cheese", image: "beefSausage", rating: 4.7, isFavorite: true, price: 12500)]),
    FoodCategoryData(category: .drink,
                     items: [
                        FoodItem(name: "Mineral Water", description: "Water", image: "mineralWater", rating: 4.5, isFavorite: true, price: 12000),
                        FoodItem(name: "Soft Drink", description: "Soft Drink", image: "softDrink", rating: 4.7, isFavorite: true, price: 12500)])
]


struct PromotionFoodData: Codable {
    let name: String
    let image: String
}

let promoData: [PromotionFoodData] = [
    PromotionFoodData(name: "Pasta Discount", image: "promosi1"),
    PromotionFoodData(name: "Special Offer", image: "promosi2"),
    PromotionFoodData(name: "Buy 1 Get 1", image: "promosi3")
]


struct AdsFoodData: Codable {
    let name: String
    let image: String
    let url: String
}

let adsData: [AdsFoodData] = [
    AdsFoodData(name: "App Order Food", image: "ads1", url: "https://www.ecount.com/id/?S=01&C=17531188503&K=161192418452&keyword=aplikasi%20pembelian&matchtype=p&gad_source=1&gbraid=0AAAAAC3zoirs0mG5DJsPujLgc1b_r6o1U&gclid=CjwKCAjw3624BhBAEiwAkxgTOoYmrUIxssgpLG6_-08djjwbe4Xcu7ps6ZgSetUmZYpJFZeSADYcihoCDC8QAvD_BwE"),
    AdsFoodData(name: "Pasta Restaurant", image: "ads2", url: "https://gambaranbrand.com/portfolio/warung-pasta/"),
    AdsFoodData(name: "Pizza Information", image: "ads3", url: "https://id.wikipedia.org/wiki/Piza"),
    AdsFoodData(name: "Pasta Information", image: "ads4", url: "https://id.wikipedia.org/wiki/Pasta")
]
