//
//  DetailFoodItemViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 02/10/24.
//

import UIKit
import Toast

class DetailFoodItemViewController: UIViewController {

    var item: FoodItem?

    
    @IBOutlet weak var toolBar: ToolBarView!
    
    @IBOutlet weak var addToChartButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    
    func setup() {
        addToChartButton.addTarget(self, action: #selector(actionAddToChartButton), for: .touchUpInside)
        
        toolBar.delegate = self
    }
    
    func loadData() {
        if let item = item {
            nameLabel.text = item.name
            imgView.image = UIImage(named: item.image)
            descriptionLabel.text = item.description
            priceLabel.text = String(item.price)
            
        }
            
    }
    @objc func actionAddToChartButton() {
        let vc = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
//    @objc func actionTap() {
//        if let foodItem = self.item {
//            CartService.shared.addToCart(food: foodItem)
//            let toast = Toast.default(
//                image: UIImage(named: foodItem.image)!,
//                title: "OK",
//                subtitle: "\(foodItem.name) telah ditambahkan ke keranjang"
//            )
//            toast.show()
//        
//        }
//    }
}


extension DetailFoodItemViewController: ToolBarViewDelegate {
    func addTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
