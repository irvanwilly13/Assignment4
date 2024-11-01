//
//  LoginViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameField: CustomInputField!
    @IBOutlet weak var passwordField: CustomInputField!
    
    var coordinator: LoginCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    func configure() {
        usernameField.setup(title: "Username", placeholder: "Masukkan Username")

        // Mengatur tampilan passwordField
        passwordField.setup(title: "Password", placeholder: "Masukkan Password")
    }
    
    func setup() {
        loginButton.addTarget(self, action: #selector(actionToLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(actionToRegisterButton), for: .touchUpInside)
    }
    
    @objc func actionToLoginButton() {
        guard let email = usernameField.textField.text, let password = passwordField.textField.text else {
            showAlert(message: "Tidak boleh kosong")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let errorMsg = self.handleFirebaseAuthError(error)
                
                self.showCustomPopup(PopupModel(tittle: "Ayo", description: errorMsg, imgView: "error", twoButton: true))
                return
            }
            
            guard let user = authResult?.user else { return }
            user.getIDToken { token, error in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    return
                }
                if let token = token {
                    self.storeTokenInKeychain(token)
                    let vc = MainTabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @objc func actionToRegisterButton() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func storeTokenInKeychain(_ token: String) {
        let tokenData = Data(token.utf8)
        KeychainHelper.shared.save(tokenData, forKey: "firebaseAuthToken")
    }
}
