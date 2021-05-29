//
//  Dot.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class Dot: Vertex {
    
    override init(with location: CGPoint) {
        super.init(with: location)
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.color = coder.decodeObject(forKey: "DotColor") as? UIColor
        self.size = coder.decodeObject(forKey: "StrokeSize") as? CGFloat
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        coder.encode(self.color, forKey: "DotColor")
        coder.encode(self.size, forKey: "DotSize")
    }
    
    override func drawWithContext(_ context: CGContext) {
        guard let location = self.location,
              let size = size, let color = color else {
            return
        }
        let x: CGFloat = location.x
        let y: CGFloat = location.y
        
        let frameSize: CGFloat = size
        let frame = CGRect(x: x - frameSize / 2.0, y: y - frameSize / 2.0, width: frameSize, height: frameSize)
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: frame)
    }
    
    override func acceptMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitDot(self)
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let dotCopy = Dot(with: self.location ?? .zero)
        dotCopy.color = UIColor(cgColor: self.color?.cgColor ?? UIColor.white.cgColor)
        dotCopy.size = self.size
        return dotCopy
    }
}
