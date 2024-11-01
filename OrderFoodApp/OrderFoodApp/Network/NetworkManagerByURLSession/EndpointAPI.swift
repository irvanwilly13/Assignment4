//
//  EndpointAPI.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 31/10/24.
//

import Foundation
import UIKit
enum ParameterEncoding: String {
    case query
    case json
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum EndpointAPI {
    case login(param: LoginParam)
    case register(registerParam: RegistParam)
    case getAllMenu
    case posts
    case users
    case getByCategory(item: String)
    case getAllProfile
    case getAllHistory
    
    func path() -> String {
        switch self {
        case .getAllMenu:
            return "/getallmenurestaurant"
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        case .getByCategory:
            return "/getbycategory"
        case .getAllProfile:
            return "/getallprofile"
        case .getAllHistory:
            return "/getallhistory"
        }
    }
    
    func method() -> HTTPMethods {
        switch self {
        case .getAllMenu, .posts, .users, .getByCategory, .getAllHistory, .getAllProfile:
            return .get
        case .login, .register:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllMenu, .posts, .users, .getAllHistory, .getAllProfile:
            return nil
        case .login(let param):
            let params = [
                "username": param.username,
                "password": param.password
            ]
            return params
        case .register(let registerParam):
            let registerParams = [
                "username": registerParam.username,
                "password": registerParam.password,
                "confirmPassword": registerParam.confirmPassword
            ]
            return registerParams
        case .getByCategory(let param):
            let param = [
                "category": param.lowercased()]
            return param
        }
    }
    
    var headers: [String:String] {
        switch self {
        case .getAllMenu, .posts, .users, .login, .register, .getByCategory, .getAllHistory, .getAllProfile:
            return [
                "Content-Type": "application/json",
                // bisa menambahkan yang lain jika diperlukan
            ]
        }
    }
    // untuk setingan api yang menggunakan query params
    var queryParams: [String: Any]? {
        switch self {
        case .getByCategory(let param):
            let param = [
                "category": param.lowercased()]
            return param
        default:
            return nil
        }
    }
    var encoding: ParameterEncoding {
        // Mengembalikan encoding yang sesuai; misalnya untuk `getByCategory`, gunakan `.url`
        switch self {
        case .getByCategory:
            return .query
        default:
            return .json
        }
    }

    // variabel getter untuk menghasilkan full url dari api
    var urlString: String {
        
        switch self {
        case .getAllMenu, .login, .register, .getByCategory, .getAllHistory, .getAllProfile:
            return Constants.baseURL + self.path()
        default:
            return Constants.baseURL + self.path()
        }
        
    }
    
    }

struct BaseConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let base = "http://localhost:3001/api/v1"
    static let userDefaults = UserDefaults.standard
}
