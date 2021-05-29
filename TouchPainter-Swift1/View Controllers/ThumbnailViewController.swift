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
        let cell: ScribbleThumbnailCell
            = collectionView.dequeueReusableCell(withReuseIdentifier: "ScribbleThumbnailCell", for: indexPath) as! ScribbleThumbnailCell
        cell.backgroundColor = .red
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        //初始化layout
        let layout = UICollectionViewFlowLayout()
        
        let itemW = (self.view.frame.width - 30) / 2
        layout.itemSize = CGSize(width: itemW, height: itemW + 40)
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        
        layout.scrollDirection = .vertical // 竖向滑动
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),collectionViewLayout: layout)
            
        collectionView.backgroundColor = .white
        
        collectionView.register(ScribbleThumbnailCell.classForCoder(), forCellWithReuseIdentifier: "ScribbleThumbnailCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
            
        view.addSubview(collectionView)
        
    }
    
    
    
    
}
