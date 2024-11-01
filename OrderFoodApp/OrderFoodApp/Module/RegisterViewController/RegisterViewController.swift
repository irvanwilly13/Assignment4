//
//  RegisterViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: BaseViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameField: CustomInputField!
    @IBOutlet weak var passwordField: CustomInputField!
    @IBOutlet weak var confirmPasswordField: CustomInputField!
    
    var coordinator: RegisterCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        registerButton.addTarget(self, action: #selector(actionToRegisterButton), for: .touchUpInside)
        
        configureInputField(usernameField)
        configureInputField(passwordField)
        configureInputField(confirmPasswordField)
    }
    func configureInputField(_ inputField: CustomInputField) {
        // Border
        inputField.layer.borderWidth = 1.5
        inputField.layer.borderColor = UIColor.gray.cgColor
        inputField.layer.cornerRadius = 10
        
        // Shadow
        inputField.layer.shadowColor = UIColor.black.cgColor
        inputField.layer.shadowOffset = CGSize(width: 0, height: 3)
        inputField.layer.shadowOpacity = 0.3
        inputField.layer.shadowRadius = 5
    }
    
    @objc func actionToRegisterButton() {
        
        guard let email = usernameField.textField.text, let password = passwordField.textField.text, let confirmPassword = confirmPasswordField.textField.text else {
            showAlert(message: "Tidak boleh kosong")
            return
        }
        
        if password != confirmPassword {
            self.showAlert(message: "Password doesn't Match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let errorMsg = self.handleFirebaseAuthError(error)
                self.showAlert(message: errorMsg)
                return
            }
            
            self.showAlertSuccess(title: "sukses", message: "berhasil membuat akun") {
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func showAlertSuccess(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Memanggil closure jika diberikan
            completion?()
        }
        
        alertController.addAction(okAction)
        
        // Menampilkan alert
        self.present(alertController, animated: true, completion: nil)
    }
}
