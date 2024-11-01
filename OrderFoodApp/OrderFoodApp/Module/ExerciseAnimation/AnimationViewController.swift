//
//  AnimationViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 07/10/24.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var subContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var animator = UIViewPropertyAnimator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimationProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimation()
    }
    
    func showAnimationProperty() {
        animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut) {
            self.subContainerView.transform = CGAffineTransform(translationX: 0.0, y: 200.0)
            self.subContainerView.backgroundColor = .green
        }
        animator.addCompletion { position in
            if position == .end {
                self.subContainerView.transform = .identity
                self.subContainerView.backgroundColor = .brown
                self.showAnimationProperty()
            }
        }
        subContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateTapButton)))
        
    }
    @objc func animateTapButton() {
        if animator.isRunning {
            animator.pauseAnimation()
        } else {
            animator.startAnimation()
        }
    }
    
    @IBAction func animationButton(_ sender: Any) {
        animator.startAnimation()
    }
    
    func showAnimation() {
        
        self.containerView.transform = CGAffineTransform(translationX: -self.view.frame.height, y: 0.0)
        self.containerView.alpha = 0.0
        self.containerView.backgroundColor = .blue
        
        UIView.animate(withDuration: 2.0,
                       delay: 0.1,
                       options: [.curveEaseIn, .repeat, .autoreverse]) {
            let translation = CGAffineTransform(translationX: 0.0, y: 0.0)
            let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
            let rotatingAngle = CGFloat(45 * Double.pi / 180)
            let rotation = CGAffineTransform(rotationAngle: rotatingAngle)
            let combinedTransform = translation.concatenating(scale).concatenating(rotation)
            
            self.containerView.transform = combinedTransform
            self.containerView.alpha = 1.0
            self.containerView.backgroundColor = .red
            self.containerView.layer.cornerRadius = 20
        }
    }
}





