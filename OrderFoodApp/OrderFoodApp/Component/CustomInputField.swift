//
//  CustomInputField.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 03/10/24.
//

import UIKit

class CustomInputField: UIView {
    
    @IBOutlet var containerCustomView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var errorUsernameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: DITEMPATKAN DI CODER KARENA MENGGUNAKAN XIB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
        
        configView()
    }
    
    func configView() {
        textField.placeholder = "Masukan Username"
        usernameLabel.text = "username"
        errorUsernameLabel.isHidden = true
        
        containerCustomView.backgroundColor = .clear
        containerCustomView.layer.borderWidth = 1
        containerCustomView.layer.borderColor = UIColor.clear.cgColor
        containerCustomView.layer.cornerRadius = 8
        containerCustomView.layer.masksToBounds = false
        textField.layer.cornerRadius = 16
        textField.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
    func setup(title: String, placeholder: String) {
        usernameLabel.text = title
        textField.placeholder = placeholder
        
    }
        
}


