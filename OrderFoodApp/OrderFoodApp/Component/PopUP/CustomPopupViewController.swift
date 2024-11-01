//
//  CustomPopupViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 09/10/24.
//

import UIKit

struct PopupModel {
    let tittle: String
    let description: String
    let imgView: String
    let twoButton: Bool
}

class CustomPopupViewController: UIViewController {

    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var popupData: PopupModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimation()
        configureData()
    }
    
    
    
    func showAnimation() {
        self.containerView.transform = CGAffineTransform(translationX: 0.0, y: self.view.frame.height)
        self.coachMarkView.alpha = 0.0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut]) {
            self.containerView.transform = .identity
            self.coachMarkView.alpha = 1.0

        }
    }
    
    func configure() {
        okButton.addTarget(self, action: #selector(actionToOK), for: .touchUpInside)
        
    }
    func configureData() {
        if let data = popupData {
            imgView.image = UIImage(named: data.imgView)
            tittleLabel.text = data.tittle
            descriptionLabel.text = data.description
            cancelButton.isHidden = !data.twoButton
        }
    }
    @objc func actionToOK() {
        self.dismiss(animated: true)
    }
}
