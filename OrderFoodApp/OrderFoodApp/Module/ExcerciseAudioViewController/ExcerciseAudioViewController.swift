//
//  ExcerciseAudioViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 07/10/24.
//

import UIKit
import AVFoundation

class ExcerciseAudioViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    
    var name = "Irvan"
    var point = 9.8

    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingLabel.text = .localized("welcome")
        greetingLabel.text = String(format: .localized("welcome"), name, "is \(point)")
        greetingLabel.font = .foodOpenSansBoldItalic(18)
        
        let attr = String(format: .localized("welcome"), name, "is \(point)")
        
        greetingLabel.attributedText = attr.coloredSubstrings([(name, .red), ("\(point)", .green)])

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
