//
//  ThumbnailViewController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class ThumbnailViewController: UIViewController,
                               UICollectionViewDelegate,
                               UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// TODO 缩略图个数
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
}
