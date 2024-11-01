//
//  ExcerciseViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

enum ShoesExcerciseType: Int, CaseIterable {
    case shoesCategory = 0
    case shoesDetailItem
//    case promoShoes
//    case adsShoes
}

class ExcerciseViewController: UIViewController {
    
    let shoessData = shoesData
    let dataAdsShoes = adsDataShoes
    var selectedCategory: ShoesCategory = .nike
    var currentItems: [ShoesItem] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateShoesItem( for: selectedCategory)


    }
    func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        
        let nib = UINib(nibName: "ShoesCategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShoesCategoryTableViewCell")
        let nibDetail = UINib(nibName: "ShoesDetailItemTableViewCell", bundle: nil)
        tableView.register(nibDetail, forCellReuseIdentifier: "ShoesDetailItemTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func updateShoesItem(for category: ShoesCategory) {
        if let selectedData = shoessData.first(where: { $0.category == category}) {
            currentItems = selectedData.items
            tableView.reloadData()
        }
    }

}

extension ExcerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = ShoesExcerciseType(rawValue: section)
        switch sectionType {
        case .shoesCategory, .shoesDetailItem: //.promoShoes:
            return 1
        //case .adsShoes:
            //return dataAdsShoes.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = ShoesExcerciseType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch sectionType {
        case .shoesCategory:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoesCategoryTableViewCell", for: indexPath) as? ShoesCategoryTableViewCell
            cell?.categoryItems = shoessData
            cell?.onSelectCategory = { category in
                self.updateShoesItem(for: category)
            }
            return cell ?? UITableViewCell()
            
        case .shoesDetailItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoesDetailItemTableViewCell", for: indexPath) as?  ShoesDetailItemTableViewCell
            cell?.items = currentItems
            
            cell?.onSelectItems = { item in
                self.navigateToDetailShoesitem(item: item)
                
            }
            return cell ?? UITableViewCell()
            
            //            case .promoShoes: // Promo sepatu (index 2)
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "PromoShoesCell", for: indexPath) as? PromoShoesCell
            //                cell?.configure(with: "Promo khusus sepatu!")
            //                return cell ?? UITableViewCell()
            //
            //            case .adsShoes: // Iklan sepatu (index 3)
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "AdsShoesCell", for: indexPath) as? AdsShoesCell
            //                let adItem = dataAdsShoes[indexPath.row]
            //                cell?.configure(with: adItem)
            //                return cell ?? UITableViewCell()
            //            }
        }
        
        
    }
    func navigateToDetailShoesitem(item: ShoesItem) {
        let vc = DetailShoesItemViewController()
        vc.itemShoe = item
        
       // vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
