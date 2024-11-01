//
//  ChartViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit



class ChartViewController: UIViewController {
    
    
    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    
    private var cartItems: [(food: FoodItem, quantity: Int)] = []
    lazy var emptyStateView = EmptyView(frame: tableView.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCartItem()
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
        let nib = UINib(nibName: "ChartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChartTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        toolBarView.setup(title: "Detail Item")
    }
    
    func loadCartItem() {
        cartItems = CartService.shared.getCartItem()
        tableView.reloadData()
        updateEmptyStateView()
        calculateTotalPrice()
        
    }
    func updateEmptyStateView() {
        tableView.isHidden = cartItems.isEmpty
        paymentButton.isHidden = cartItems.isEmpty
        shouldShowErrorView(status: cartItems.isEmpty)
    }
    func shouldShowErrorView(status: Bool) {
        switch status {
        case true:
            if !view.subviews.contains(emptyStateView) {
                view.addSubview(emptyStateView)
            } else {
                emptyStateView.isHidden = false
            }
        case false:
            if view.subviews.contains(emptyStateView) {
                emptyStateView.isHidden = true
            }
        }
    }
    func calculateTotalPrice() {
        let totalPrice = cartItems.reduce(0) { (result, item) -> Double in
            return result + (item.food.price * Double(item.quantity))
        }
        
        // Mengatur format Rupiah pada priceLabel
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "id_ID") // Format Indonesia (IDR)
        
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) {
            priceLabel.text = formattedPrice
        } else {
            priceLabel.text = "Rp \(totalPrice)"
        }
    }
}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as? ChartTableViewCell
        if cell == nil {
            return UITableViewCell()
        }
        
        let item = cartItems[indexPath.row]
        cell?.configure(with: item.food, quantity: item.quantity)
        cell?.delegate = self
        //cell?.delegate = self
        return cell!
    }
}


extension ChartViewController: FoodChartItemTableViewCellDelegate {
    func cartItemCell(didTapAddFor food: FoodItem) {
        CartService.shared.addToCart(food: food)
        loadCartItem()
    }
    
    func cartItemCell(didtapRemoveFor food: FoodItem) {
        CartService.shared.removeFromCart(food: food)
        loadCartItem()
    }
}
