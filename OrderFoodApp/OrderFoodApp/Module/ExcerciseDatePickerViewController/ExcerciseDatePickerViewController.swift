//
//  ExcerciseDatePickerViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 10/10/24.
//

import UIKit

class ExcerciseDatePickerViewController: BaseViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var days = Array(1...31)
    let months = Array(1...12)
    let years = Array(1900...2024)
    
    
    var selectedDay = 13
    var selectedMonth = 6
    var selectedYear = 1997
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDateLabel()
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }
    func updateDateLabel() {
            dateLabel.text = "Selected Date: \(selectedDay)-\(selectedMonth)-\(selectedYear)"
        }
    func isLeapYear(_ year: Int) -> Bool {
            return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
        }
    func updateDaysForSelectedMonth() {
            if selectedMonth == 2 { // Februari
                if isLeapYear(selectedYear) {
                    self.days = Array(1...29) // 29 hari di tahun kabisat
                } else {
                    self.days = Array(1...28) // 28 hari di tahun non-kabisat
                }
            } else if [4, 6, 9, 11].contains(selectedMonth) {
                self.days = Array(1...30) // Bulan dengan 30 hari
            } else {
                self.days = Array(1...31) // Bulan dengan 31 hari
            }
            pickerView.reloadComponent(0) // Muat ulang komponen hari setelah diperbarui
            
            // Periksa apakah hari yang dipilih masih valid dalam bulan yang baru
            if selectedDay > days.count {
                selectedDay = days.count
            }
        }


}

extension ExcerciseDatePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return days.count
        case 1:
            return months.count
        case 2:
            return years.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0: return "\(days[row])" // Menampilkan hari
            case 1: return "\(months[row])" // Menampilkan bulan
            case 2: return "\(years[row])" // Menampilkan tahun
            default: return nil
            }
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedDay = days[row] // Memperbarui hari yang dipilih
        case 1:
            selectedMonth = months[row] // Memperbarui bulan yang dipilih
            updateDaysForSelectedMonth()
        case 2:
            selectedYear = years[row] // Memperbarui tahun yang dipilih
            updateDaysForSelectedMonth()
        default:
            break
        }
        
        updateDateLabel()
    }
}
