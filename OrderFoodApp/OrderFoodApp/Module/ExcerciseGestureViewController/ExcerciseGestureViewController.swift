//
//  ExcerciseGestureViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 10/10/24.
//

import UIKit

class ExcerciseGestureViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        //swipeGesture()
        //pinchGesture()
        //rotationGesture()
        //panGesture()
        //longGesture()
    }
    

    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.numberOfTapsRequired = 1 // Atur jumlah ketukan
        containerView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        showAlert(message: "hahaha")
    }
    
    func swipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = .left // Mengatur arah sapuan
        containerView.addGestureRecognizer(swipeGesture)
    }
    @objc func handleSwipe() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.center = CGPoint(x: self.containerView.center.x - 200, y: self.containerView.center.y)
        }
    }
    
    func pinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        containerView.addGestureRecognizer(pinchGesture)
    }
    @objc func handlePinch(gesture: UIPinchGestureRecognizer) {
        let scale = gesture.scale
        print("Pinch gesture detected with scale: \(scale)")
    }
    
    func rotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        containerView.addGestureRecognizer(rotationGesture)
    }
    @objc func handleRotation(gesture: UIRotationGestureRecognizer) {
        let rotation = gesture.rotation
        print("Rotation gesture detected with rotation: \(rotation)")
    }
    
    func panGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        containerView.addGestureRecognizer(panGesture)
    }
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        print("Pan gesture detected with translation: \(translation)")
    }
    func longGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 detik
        containerView.addGestureRecognizer(longPressGesture)
    }
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long press detected - background turns red")
            
            // Mengubah warna background menjadi merah saat ditekan
            UIView.animate(withDuration: 0.3) {
                self.containerView.backgroundColor = .systemRed
            }
        } else if gesture.state == .ended {
            print("Long press released - background turns green")
            
            // Mengubah warna background menjadi hijau saat dilepas
            UIView.animate(withDuration: 0.3) {
                self.containerView.backgroundColor = .systemGreen
            }
        }
    }
    
}
