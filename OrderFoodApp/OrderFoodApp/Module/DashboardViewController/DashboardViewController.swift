//
//  DashboardViewController.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 30/09/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay


enum FoodDashboardType: Int, CaseIterable {
    case foodCatergory = 0
    case foodDetailItem
    case promoFood
    case ads
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var deliveryToButton: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    let viewModel = DashboardViewModel()
    
    var currentItems: [FoodItem] = []
    var foodsData: [FoodCategoryData] = [] {
        didSet{
            currentItems = foodsData.first?.items ?? []
        }
    }
    var dataPromo: [PromotionFoodData] = []
    var dataAds: [AdsFoodData] = []
    let disposeBag = DisposeBag()
    
    
    //    let dataAds = adsData
    //    let dataPromo = promoData
    
    var selectedCategory: FoodCategory = .spagethi
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateFoodItem( for: selectedCategory)
        hideNavigationBar()
        bindDataByRx()
        setupRefreshControl()
        
    }
    func bindDataByRx() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                    self.updateErrorStateView(isShow: true)
                case .finished:
                    self.tableView.hideSkeleton()
                    self.updateErrorStateView(isShow: true)
                    print("finished")
                default:
                    break
                }
            }
            
        } ).disposed(by: disposeBag)
        
        viewModel.foodAppData.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.foodsData = data.foodData
            self.dataPromo = data.promoData
            self.dataAds = data.adsData
            
            if let firstCategory = self.foodsData.first?.category {
                self.updateFoodItem(for: firstCategory)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        } ).disposed(by: disposeBag)
        viewModel.fetchRequestData()
    }
    
    func bindData() {
        viewModel.onUpdateFoodData = { [weak self] foodData, promoData, adsData in
            guard let self = self else { return }
            
            guard let validFoodData = foodData,
                  let validPromoData = promoData,
                  let validAdsData = adsData else {
                return
            }
            self.foodsData = validFoodData
            self.dataPromo = validPromoData
            self.dataAds = validAdsData
            
            if let firstCategory = self.foodsData.first?.category {
                self.updateFoodItem(for: firstCategory)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.onLoading = { [weak self] loading in
            guard let self = self else { return }
            guard let loading = loading else { return }
            DispatchQueue.main.async {
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                    self.updateErrorStateView(isShow: true)
                case .finished:
                    self.tableView.hideSkeleton()
                    print("finished")
                default:
                    break
                }
            }
            
        }
        viewModel.requestData()
    }
    
    func setup() {
        tableView.register(UINib(nibName: "FoodCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCategoryTableViewCell")
        tableView.register(UINib(nibName: "FoodDetailItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodDetailItemTableViewCell")
        tableView.register(UINib(nibName: "PromoFoodTableViewCell", bundle: nil), forCellReuseIdentifier: "PromoFoodTableViewCell")
        tableView.register(UINib(nibName: "AdsTableViewCell", bundle: nil), forCellReuseIdentifier: "AdsTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        errorStateView.delegate = self
        
        filterButton.addTarget(self, action: #selector(tapToOptionButton), for: .touchUpInside)
    }
    
    @objc func tapToOptionButton() {
        let vc = LeftMenuBottomSheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func updateFoodItem(for category: FoodCategory) {
        if let selectedData = foodsData.first(where: { $0.category == category}) {
            self.currentItems = selectedData.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
    }
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func refreshData() {
        viewModel.requestData()
        tableView.refreshControl?.endRefreshing()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()  // Reload table view di main thread
            self.tableView.refreshControl?.endRefreshing() // Hentikan refresh di main thread
        }
    }
    func updateErrorStateView(isShow: Bool) {
        tableView.isHidden = isShow
        shouldShowErrorView(status: isShow)
    }
    func shouldShowErrorView(status: Bool) {
        switch status {
        case true:
            if !view.subviews.contains(errorStateView) {
                view.addSubview(errorStateView)
            } else {
                errorStateView.isHidden = false
            }
        case false:
            if view.subviews.contains(errorStateView) {
                errorStateView.isHidden = true
            }
        }
    }
    
    
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FoodDashboardType.allCases.count // Ini akan mengembalikan 4 / jumlah total section yang dibuat section: satu untuk kategori dan satu untuk detail.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let sectionType = FoodDashboardType(rawValue: section)
            switch sectionType {
            case .foodCatergory, .foodDetailItem:
                return 1
            case .promoFood:
                return dataPromo.count > 0 ? 1 : 0
            case .ads:
                return dataAds.count
            default:
                return 0
            }
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let sectionType = FoodDashboardType(rawValue: indexPath.section)
            switch sectionType {
            case .foodCatergory:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCategoryTableViewCell", for: indexPath) as? FoodCategoryTableViewCell
                cell?.categoryItems = foodsData
                cell?.onSelectCategory = { category in
                    self.updateFoodItem(for: category)
                }
                return cell ?? UITableViewCell()
                
            case .foodDetailItem:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailItemTableViewCell", for: indexPath) as? FoodDetailItemTableViewCell
                cell?.items = currentItems
                cell?.onSelectItems = { item in
                    self.navigateToDetail(item: item)
                }
                return cell ?? UITableViewCell()
                
            case .promoFood:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PromoFoodTableViewCell", for: indexPath) as? PromoFoodTableViewCell
                cell?.dataPromosi = dataPromo
                return cell ?? UITableViewCell()
                
            case .ads:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTableViewCell", for: indexPath) as? AdsTableViewCell
                cell?.configure(data: dataAds[indexPath.row])
                return cell ?? UITableViewCell()
                
            default:
                return UITableViewCell()
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = FoodDashboardType(rawValue: indexPath.section)
        switch cellType {
        case .ads:
            let vc = AdsViewController()
            vc.url = dataAds[indexPath.row].url
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
        
        func navigateToDetail(item: FoodItem) {
            let vc = DetailFoodItemViewController()
            vc.item = item
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

extension DashboardViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 4
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 0
        }
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let sectionType = FoodDashboardType(rawValue: indexPath.section)
        switch sectionType {
        case .foodCatergory:
            return "FoodCategoryTableViewCell"
        case .foodDetailItem:
            return "FoodDetailItemTableViewCell"
        case .promoFood:
            return "PromoFoodTableViewCell"
        default:
            return ""
        }
    }
    
}

extension DashboardViewController: ErrorViewControllerDelegate {
    func buttonTap() {
        self.updateErrorStateView(isShow: false)
        viewModel.requestData()
    }
    
}

