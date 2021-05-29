//
//  ScribbleThumbnailCell.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class ScribbleThumbnailCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(thumbnailView: UIView) {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        thumbnailView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.contentView.addSubview(thumbnailView)
    }
}
