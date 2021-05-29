//
//  Mark.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

protocol Mark: NSObject, NSCopying, NSSecureCoding {
    var color: UIColor? { get set }
    var size: CGFloat? { get set }
    var location: CGPoint? { get set }
    
    // 节点个数
    func count() -> Int
    // 最后一个节点
    func lastChild() -> Mark?
   
    func copy() -> Any?
    // 添加一个节点
    func addMark(mark: Mark) -> Void
    // 删除一个节点
    func remove(mark: Mark) -> Void
    
    func childMarkAtIndex(_ index: Int) -> Mark?
    
    func drawWithContext(_ context: CGContext)
    // TODO 访问者 
    func acceptMarkVisitor(_ visitor: MarkVisitor)
}
