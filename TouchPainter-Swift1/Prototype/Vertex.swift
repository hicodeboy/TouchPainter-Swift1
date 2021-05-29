//
//  Vertex.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class Vertex:NSObject, Mark {
    
    var color: UIColor?

    var size: CGFloat?

    var location: CGPoint? = .zero
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    override init() {
        super.init()
    }
    
    init(with location: CGPoint) {
        self.location = location
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let vertexCopy = Vertex.init(with: self.location ?? CGPoint(x: 0, y: 0))
        return vertexCopy
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.location, forKey: "VertexLocation")
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.location = coder.decodeObject(forKey: "VertexLocation") as? CGPoint
    }
    
    
    func count() -> Int {
        return 0
    }

    func lastChild() -> Mark? {
        return nil
    }
    
    func copy() -> Any? {
        return nil
    }
    
    func addMark(mark: Mark) { }

    func remove(mark: Mark) {}

    func childMarkAtIndex(_ index: Int) -> Mark? {
        return nil
    }
    
    func drawWithContext(_ context: CGContext) {
        guard let location = location else {
            return
        }
        context.addLine(to: location)
    }
    
    func acceptMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitVertex(self)
    }
    
}
