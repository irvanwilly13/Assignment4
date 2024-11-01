//
//  DashboardViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit

enum FoodDashboardType: Int, CaseIterable {
    case foodCatergory = 0
    case foodDetailItem
    case promoFood
    case ads
}

class DashboardViewController: UIViewController {
    
    let foodsData = foodData
    let dataAds = adsData
    var selectedCategory: FoodCategory = .pizza
    var currentItems: [FoodItem] = []
    
    @IBOutlet weak var deliveryToButton: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateFoodItem( for: selectedCategory)
        
    }
    
    func setup() {
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width: 130, height: 204)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        
        let nib = UINib(nibName: "FoodCategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FoodCategoryTableViewCell")
        let nibDetail = UINib(nibName: "FoodDetailItemTableViewCell", bundle: nil)
        tableView.register(nibDetail, forCellReuseIdentifier: "FoodDetailItemTableViewCell")
        let nibDetailPromo = UINib(nibName: "PromoFoodTableViewCell", bundle: nil)
        tableView.register(nibDetailPromo, forCellReuseIdentifier: "PromoFoodTableViewCell")
        let nibAds = UINib(nibName: "AdsTableViewCell", bundle: nil)
        tableView.register(nibAds, forCellReuseIdentifier: "AdsTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filterButton.addTarget(self, action: #selector(actionTapFilter), for: .touchUpInside)
    }
    
    @objc func actionTapFilter() {
        let vc = LeftMenuBottomSheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func updateFoodItem(for category: FoodCategory) {
        if let selectedData = foodData.first(where: { $0.category == category}) {
            currentItems = selectedData.items
            tableView.reloadData()
        }
    }
    
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionType = FoodDashboardType(rawValue: section)
        switch sectionType {
        case .foodCatergory, .foodDetailItem, .promoFood:
            return 1
        case .ads:
            return dataAds.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = FoodDashboardType(rawValue: indexPath.section)
        switch sectionType {
        case .foodCatergory: // case index 0
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCategoryTableViewCell", for: indexPath) as?  FoodCategoryTableViewCell
            cell?.categoryItems = foodsData
            cell?.onSelectCategory = { category in
                self.updateFoodItem(for: category)
                
            }
            return cell ?? UITableViewCell()
            
        case .foodDetailItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailItemTableViewCell", for: indexPath) as?  FoodDetailItemTableViewCell
            cell?.items = currentItems
            
            cell?.onSelectItems = { item in
                self.navigateToDetailFooditem(item: item)
                
            }
            return cell ?? UITableViewCell()
            
        case .promoFood:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromoFoodTableViewCell", for: indexPath) as? PromoFoodTableViewCell
            return cell ?? UITableViewCell()
            
        case .ads:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTableViewCell", for: indexPath) as? AdsTableViewCell
            cell?.configure(data: dataAds[indexPath.row])
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = FoodDashboardType(rawValue: section)
        switch sectionType {
        case .foodCatergory, .foodDetailItem, .promoFood:
            return nil
        case .ads:
            // Buat UIView untuk header
            let headerView = UIView()
            headerView.backgroundColor = UIColor.red
            
            // Buat UILabel untuk menampilkan teks
            let headerLabel = UILabel()
            headerLabel.text = "Iklan Gratis" // Ubah teks sesuai kebutuhan
            headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
            headerLabel.textColor = UIColor.black
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Tambahkan label ke dalam view
            headerView.addSubview(headerLabel)
            
            // Tambahkan constraint untuk menempatkan label
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = FoodDashboardType(rawValue: section)
        switch sectionType {
        case .ads:
            return 60
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = FoodDashboardType(rawValue: indexPath.section)
        switch sectionType {
        case .ads:
            print("\(indexPath.section) : \(indexPath.row)")
        default :
            break
        }

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func navigateToDetailFooditem(item: FoodItem) {
        let vc = DetailFoodItemViewController()
        vc.item = item
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
