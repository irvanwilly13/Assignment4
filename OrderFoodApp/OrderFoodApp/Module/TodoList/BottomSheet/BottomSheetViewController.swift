//
//  BottomSheetViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit

class FilterStatus {
    static let shared = FilterStatus()
    private init() {}
    
    var minAge: Int = 0
    var maxAge: Int = 100
    var name: String?
    
    func reset() {
        self.minAge = 0
        self.maxAge = 100
        self.name = nil
    }
}


class BottomSheetViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var minAgeSlider: UISlider!
    @IBOutlet weak var maxAgeSlider: UISlider!
    @IBOutlet weak var minAgeLabel: UILabel!
    @IBOutlet weak var maxAgeLabel: UILabel!
    
    //closure yang akan di panggil ketika filterButton di clock
    var onApplyFilter: ((_ minAge: Int, _ maxAge: Int, _ name: String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSavedFilter()
    }
    func setupUI() {
        
        minAgeSlider.minimumValue = 0
        minAgeSlider.maximumValue = 30
        minAgeSlider.value = 20
        minAgeSlider.addTarget(self, action: #selector(ageSliderChanged), for: .valueChanged)
        
        maxAgeSlider.minimumValue = 30
        maxAgeSlider.maximumValue = 100
        maxAgeSlider.value = 31
        maxAgeSlider.addTarget(self, action: #selector(ageSliderChanged), for: .valueChanged)
        filterButton.addTarget(self, action: #selector(applyFilterButtonTapped), for: .touchUpInside)
    }
    
    func loadSavedFilter() {
        let filterStatus = FilterStatus.shared
        minAgeSlider.value = Float(filterStatus.minAge)
        minAgeLabel.text = "Min Age: \(filterStatus.minAge)"
        
        maxAgeSlider.value = Float(filterStatus.maxAge)
        maxAgeLabel.text = "Max Age: \(filterStatus.maxAge)"
        searchTextField.text = filterStatus.name
    }
    
    @objc func ageSliderChanged(_ sender: UISlider) {
        if sender ==  maxAgeSlider {
            let selectedAge = Int(sender.value)
            maxAgeLabel.text = "Max Age: \(selectedAge)"
        }
        if sender == minAgeSlider {
            let selectedAge = Int(sender.value)
            minAgeLabel.text = "Min Age \(selectedAge)"
        }
    }
    
    @objc func applyFilterButtonTapped(_ sender: UIButton) {
        
        let minAge = Int(minAgeSlider.value)
        let maxAge = Int(maxAgeSlider.value)
        let name = searchTextField.text?.isEmpty ==  true ? nil : searchTextField.text
        
        // penyimpanan filter setting di singleton
        FilterStatus.shared.minAge = minAge
        FilterStatus.shared.maxAge = maxAge
        FilterStatus.shared.name = name
        
        onApplyFilter?(minAge, maxAge, name)
        dismiss(animated: true, completion: nil)
    }

}
