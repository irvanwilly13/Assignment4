//
//  ShoesDetailItemTableViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

class ShoesDetailItemTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var items: [ShoesItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var onSelectItems: ((_ category: ShoesItem) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup() {
        let layout = CustomLayoutCollectionView()
        collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "ShoesDetailItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ShoesDetailItemCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ShoesDetailItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoesDetailItemCollectionViewCell", for: indexPath) as?  ShoesDetailItemCollectionViewCell
        
        cell?.setup(data: items[indexPath.row])

        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 2) - 10, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section) : \(indexPath.row)")
        onSelectItems?(items[indexPath.row])
    }
}
