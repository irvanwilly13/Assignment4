//
//  ExcerciseModel.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import Foundation
import UIKit

enum ShoesCategory: String, CaseIterable {
    case nike
    case adidas
    case puma
    case asics
    
    func setImage() -> String {
        switch self {
        case .nike:
            return "nike"
        case .adidas:
            return "adidas"
        case .puma:
            return "puma"
        case .asics:
            return "asics"
        }
    }
}

struct ShoesItem: Hashable {
    let name: String
    let description: String
    let image: String
    let rating: Double
    let isFavorite: Bool
    let price: Double
}

struct ShoesCategoryData {
    let category: ShoesCategory
    let items: [ShoesItem]
}

let shoesData: [ShoesCategoryData] = [
    ShoesCategoryData(category: .nike,
                     items: [
                        ShoesItem(name: "Nike", description: "Jordan", image: "nikeJordan", rating: 4.5, isFavorite: true, price: 12000),
                        ShoesItem(name: "nike", description: "Panda", image: "nikePanda", rating: 4.7, isFavorite: true, price: 12500)]),
    
    ShoesCategoryData(category: .adidas,
                     items: [
                        ShoesItem(name: "Adidas", description: "Samba", image: "adidasSamba", rating: 4.5, isFavorite: true, price: 12000),
                        ShoesItem(name: "Adidas", description: "NMD", image: "adidasNMD", rating: 4.7, isFavorite: true, price: 12500)]),
    ShoesCategoryData(category: .puma,
                     items: [
                        ShoesItem(name: "Puma", description: "BTS", image: "pumaBTS", rating: 4.5, isFavorite: true, price: 12000),
                        ShoesItem(name: "Puma", description: "Race", image: "pumaRace", rating: 4.7, isFavorite: true, price: 12500)]),
    ShoesCategoryData(category: .asics,
                     items: [
                        ShoesItem(name: "Asics", description: "walk", image: "asicsWalk", rating: 4.5, isFavorite: true, price: 12000),
                        ShoesItem(name: "Asics", description: "Running", image: "asicsRun", rating: 4.7, isFavorite: true, price: 12500)])
    ]

struct AdsShoesData {
    let name: String
    let image: String
}

let adsDataShoes: [AdsShoesData] = [
    AdsShoesData(name: "nike", image: "nike"),
    AdsShoesData(name: "adidas", image: "adidas"),
    AdsShoesData(name: "puma", image: "puma")
]
