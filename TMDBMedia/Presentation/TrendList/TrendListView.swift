//
//  TrendListView.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class TrendListView: BaseView {
    private enum Metric {
        static let defaultInset: CGFloat = 20.0
    }
    
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(UINib(nibName: TrendListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendListCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func configureView() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCollectionViewFlowlayout(numberOfLines: Int, inset: Double) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: .zero, right: inset)
        let itemSize = (collectionView.frame.width - (2*inset)) / Double(numberOfLines)
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize )
        collectionView.collectionViewLayout = flowLayout
    }
}
