//
//  ViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    let disposeBag = DisposeBag()
    
    var coordinator: ViewControllerCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator = ViewControllerCoordinator(navigationController: self.navigationController) // Inisialisasi coordinator
                setup()

        
    }
    
    func setup() {
        // Menggunakan Rx untuk bind action dari loginButton
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.moveToLogin()
                
//                   let vc = LoginViewController()
//                   self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        // Menggunakan Rx untuk bind action dari registerButton
        registerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.moveToRegister()
//                   let vc = RegisterViewController()
//                   self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
 
 func moveToLogin() {
     coordinator?.showLogin()
//        let loginCoordinator = LoginCoordinator(navigationController: navigationController ?? UINavigationController())
//        loginCoordinator.start()
 }
 func moveToRegister() {
     coordinator?.showRegister()
 }
}
