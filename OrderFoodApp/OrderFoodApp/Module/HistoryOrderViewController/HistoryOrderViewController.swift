//
//  HistoryOrderViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit

class HistoryOrderViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var historyData: [HistoryFoodData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        hideNavigationBar()
        
        
    }
    func setup() {
        // Set delegate dan dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register cell
        let nib = UINib(nibName: "HistoryOrderTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryOrderTableViewCell")
        
    }
    func loadData() {
        // Isi array dengan data riwayat pesanan
        historyData = [
            HistoryFoodData(name: "Carbonara Spagethi ", image: "spagethi1", description: "Classic Italian Spagethi", price: 56000),
            HistoryFoodData(name: "Classic Lasagna ", image: "lasagna1", description: "Classic Italian Lasagna", price: 60000),
            HistoryFoodData(name: "American Pizza", image: "pizza2", description: "Pizza American Favorite",price: 60000),
            HistoryFoodData(name: "Milk Shake", image: "drink3", description: "Milk Shake Flavour", price: 34000)
        ]
        tableView.reloadData() // Refresh table view setelah data dimuat
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
    }
    
    
}

extension HistoryOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Jumlah baris di dalam table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    // Konfigurasi setiap cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryOrderTableViewCell", for: indexPath) as! HistoryOrderTableViewCell
        let data = historyData[indexPath.row]
        
        // Konfigurasi cell dengan data
        cell.configure(data: data)
        
        return cell
    }
    
    // Aksi ketika cell dipilih
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = historyData[indexPath.row]
        print("Pesanan terpilih: \(selectedData.name)")
    }
}


