//
//  CanvasView.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import UIKit

class CanvasView: UIView {
    weak var mark: Mark?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext(),
              let mark = mark else {
                return
        }
//        mark.drawWithContext(context)
        //  也可以使用访问者
        let markRender = MarkRenderer(with: context)
        mark.acceptMarkVisitor(markRender)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
