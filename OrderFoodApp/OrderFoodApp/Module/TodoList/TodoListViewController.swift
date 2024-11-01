//
//  TodoListViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 02/10/24.
//

import UIKit

class TodoListViewController: UIViewController {
    
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var chartList = ChartList.shared
    
    var isFiltered: Bool = false
    
    var filteredDataList: [ProfileData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupView()
    }
    
    func setupView() {
        addButton.addTarget(self, action: #selector(actionAddButton), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(actionFilterButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(actionResetButton), for: .touchUpInside)
        
        let nib = UINib(nibName: "ChartItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChartItemTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @objc func actionAddButton() {
        showInputAllert()
    }
    func showInputAllert() {
        let alertController = UIAlertController(title: "Enter your Name", message: "Please enter your name below", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Age"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Status"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            if let name = alertController?.textFields?[0].text,
               let age = alertController?.textFields?[1].text,
               let status = alertController?.textFields?[2].text {
                let data = ProfileData(name: name,
                                       age: Int(age) ?? 0,
                                       status: status)
                self.chartList.addChart(data: data)
                self.tableView.reloadData()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func actionResetButton() {
        self.isFiltered = false
        FilterStatus.shared.reset()
        self.tableView.reloadData()
    }
    
    @objc func actionFilterButton() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .automatic
        
        bottomSheetVC.onApplyFilter = { minAge, maxAge, name in
            var result = self.chartList.dataList
            if let name = name {
                result = result.filter { $0.name.lowercased().contains(name.lowercased()) }
            }
            result = result.filter { $0.age >= minAge && $0.age <= maxAge}
            self.filteredDataList = result
            self.isFiltered = true
            self.tableView.reloadData()
        }
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return 450
            }
            
            sheet.detents = [customDetent]
            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredDataList.count : chartList.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartItemTableViewCell", for: indexPath) as?  ChartItemTableViewCell
       
        let data = isFiltered ? filteredDataList[indexPath.row] : chartList.dataList[indexPath.row]
        cell?.configure(data: self.chartList.dataList[indexPath.row])
        return cell ?? UITableViewCell()

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        self.showEditAllertChart(idx: index)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.chartList.removeChart(idx: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
}

extension TodoListViewController {
    func showEditAllertChart (idx: Int) {
        let alertController = UIAlertController(title: "Edit Chart", message: "Silakan Update Profile Anda", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = self.chartList.dataList[idx].name
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.text = String(self.chartList.dataList[idx].age)
            
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Status"
            textField.text = self.chartList.dataList[idx].status
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            if let name = alertController?.textFields?[0].text,
               let age = alertController?.textFields?[1].text,
               let status = alertController?.textFields?[2].text {
                let data = ProfileData(name: name,
                                       age: Int(age) ?? 0,
                                       status: status)
                self.chartList.editChart(idx: idx, data: data)
                self.tableView.reloadData()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

