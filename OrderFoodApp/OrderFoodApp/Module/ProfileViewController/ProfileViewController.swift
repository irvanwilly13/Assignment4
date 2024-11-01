//
//  ProfileViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var taskDoneLabel: UIView!
    @IBOutlet weak var taskLeftLabel: UIView!
    @IBOutlet weak var changePasswordLabel: UIStackView!
    @IBOutlet weak var changeAccountNameLabel: UIStackView!
    @IBOutlet weak var appSettingsLabel: UIStackView!
    @IBOutlet weak var changeImgButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    
    var name = "irvan"
    var point = 9.8
    
    let pickerImage = UIImagePickerController()
    var imageChosen = [UIImagePickerController.InfoKey: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImgButton.addTarget(self, action: #selector(tapGallery), for: .touchUpInside)
        greetingLabel.text = .localized("welcome")
        greetingLabel.text = String(format: .localized("welcome"), name, "Idr \(point)")
        greetingLabel.font = .foodOpenSansBoldItalic(18)
        
        let attr = String(format: .localized("welcome"), name, "Idr \(point)")
        
        greetingLabel.attributedText = attr.coloredSubstrings([(name, .red), ("\(point)", .green)])
    }
    
    @objc func tapGallery() {
        self.pickerImage.allowsEditing = true
        self.pickerImage.delegate = self
        self.pickerImage.sourceType = .photoLibrary
        self.present(self.pickerImage, animated: true)
    }
    
    @IBAction func playButton(_ sender: Any) {
        playAudio("wearethechampion")
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        audioPlayer?.stop()
    }
    
    // MARK: MENGGUNAKAN DO CATHCH DIGUNAKAN UNTUK MENCOBA
    func playAudio(_ audioName: String, type: String = "mp3") {
        guard let path = Bundle.main.path(forResource: audioName, ofType: type) else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        audioPlayer?.play()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.imageChosen = info
        self.imgView.image = image
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
