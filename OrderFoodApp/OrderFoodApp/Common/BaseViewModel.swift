//
//  BaseViewModel.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 01/11/24.
//

import Foundation
import RxSwift
import RxCocoa

enum StateLoading: Int {
    case notLoad
    case loading
    case finished
    case failed
}

class BaseViewModel {
    public let bag: DisposeBag = DisposeBag()
    public let loadingState = BehaviorRelay<StateLoading>(value: .notLoad)
    
    init() {}
}
