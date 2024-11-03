//
//  SuccessPaymentViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 01/11/24.
//

import UIKit

class SuccessPaymentViewController: UIViewController {

    @IBOutlet weak var backToHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setup() {
        backToHomeButton.addTarget(self, action: #selector(actionToButton), for: .touchUpInside)

    }
    @objc func actionToButton() {
        let vc = DashboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
