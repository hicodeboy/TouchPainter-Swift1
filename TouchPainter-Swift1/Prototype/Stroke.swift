//
//  Stroke.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class Stroke: Vertex {
    var childred:[Mark] = []
    
    override init() {
        super.init(with: .zero)
    }
    
    override var location: CGPoint? { set {}
        get {
            if childred.count > 0 {
                let mark = childred[0]
                return mark.location
            }
            return CGPoint.zero
        }
    }
    
    override func addMark(mark: Mark) {
        childred.append(mark)
    }
    
    override func remove(mark: Mark) {
        let index = childred.firstIndex(where: {
            $0.location == mark.location &&
                $0.size == mark.size &&
                $0.color == mark.color
        })
        guard let idx = index else {
            return
        }
        childred.remove(at: idx)
    }
    
    override func childMarkAtIndex(_ index: Int) -> Mark? {
        if (index >= childred.count) {
            return nil
        }
        return childred[index]
    }
    
    override func lastChild() -> Mark? {
        return childred.last
    }
    
    override func count() -> Int {
        return childred.count
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let strockCopy = Stroke()
        strockCopy.color = self.color
        strockCopy.size = self.size
        for child in childred {
            let childCopy: Mark = child.copy() as! Mark
            strockCopy.addMark(mark: childCopy)
        }
        return strockCopy
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.color = coder.decodeObject(of: UIColor.self, forKey: "StrokeColor")
        self.size = coder.decodeObject(forKey: "StrokeSize") as? CGFloat
        self.childred = coder.decodeObject(forKey: "StrokeChildren") as? [Mark] ?? []
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(self.color, forKey: "StrokeColor")
        coder.encode(self.size, forKey: "StrokeSize")
        coder.encode(self.childred, forKey: "StrokeChildren")
    }
    
    override func drawWithContext(_ context: CGContext) {
        context.move(to: self.location ?? .zero)
        for mark in childred {
            mark.drawWithContext(context)
        }
        context.setLineWidth(self.size ?? 0.0)
        context.setLineCap(.round)
        context.setStrokeColor(self.color?.cgColor ?? UIColor.white.cgColor)
        context.strokePath()
    }
    
    override func acceptMarkVisitor(_ visitor: MarkVisitor) {
        for m in childred.enumerated() {
            m.element.acceptMarkVisitor(visitor)
        }
        visitor.visitStroke(self)
    }
}
