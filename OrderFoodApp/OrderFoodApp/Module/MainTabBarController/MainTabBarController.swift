//
//  MainTabBarController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    let btnMiddle : UIButton = {
          let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
          btn.setTitle("", for: .normal)
          btn.backgroundColor = UIColor.orange
          btn.layer.cornerRadius = 30
          btn.layer.shadowColor = UIColor(named: "#F9881F")?.cgColor
          btn.layer.shadowOpacity = 0.2
          btn.layer.shadowOffset = CGSize(width: 4, height: 4)
          btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
          btn.tintColor = UIColor.white
          return btn
        }()
    
    let dashboard = UINavigationController(rootViewController: DashboardViewController())
    let chart = UINavigationController(rootViewController: ChartViewController())
    let middle = UINavigationController(rootViewController: TodoListViewController())
    let history = UINavigationController(rootViewController: HistoryOrderViewController())
    let profil = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        configureTabBar()
    }
    
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        self.tabBar.backgroundColor = UIColor.clear
        self.tabBar.tintColor = UIColor(named: "#F9881F")
    }
    // MARK: UNTUK URUTAN TAB BAR
    func configureTabBar() {
        self.setViewControllers([dashboard,chart,middle,history,profil], animated: true)
        
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
    }
    
    // MARK: UNTUK MENAMPILKAN SIMBOL PADA TABBAR >>>
    func configureUITabBarItems() {
        dashboard.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.dashboardSymbol, tag: 0)
        chart.tabBarItem = UITabBarItem(title: "Chart", image: SFSymbols.chartSymbol, tag: 1)
        history.tabBarItem = UITabBarItem(title: "history", image: SFSymbols.historySymbol, tag: 2)
        profil.tabBarItem = UITabBarItem(title: "Profil", image: SFSymbols.profilSymbol, tag: 3)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        UITabBar.appearance().tintColor = UIColor.magenta
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.isNavigationBarHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    

    
 
    
}

