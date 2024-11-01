//
//  DetailShoesItemViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

class DetailShoesItemViewController: UIViewController {
    
    var itemShoe: ShoesItem?
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countButton: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
   

    
    
    func loadData() {
        if let item = itemShoe {
            
            imgView.image = UIImage(named: item.image)
            
            
        }
        
        
        
    }
}
