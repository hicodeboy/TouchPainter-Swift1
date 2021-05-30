//
//  MarkRenderer.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class MarkRenderer: MarkVisitor {
    
    
    var context: CGContext
    var shouldMoveContextToDot: Bool
    
    required init(with context: CGContext) {
        self.context = context
        shouldMoveContextToDot = true
    }
    
    func visitMark(mark: Mark) {
    }
    
    func visitVertex(_ vertex: Vertex) {
        guard let location = vertex.location else {
            return
        }
        if (shouldMoveContextToDot) {
            context.move(to: location)
            shouldMoveContextToDot = false
        } else {
            context.addLine(to: location)
        }
    }
    
    func visitStroke(_ stroke: Stroke) {
        guard let color = stroke.color,
              let size = stroke.size
        else {
            return
        }
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(size)
        context.setLineCap(.round)
        context.strokePath()
        shouldMoveContextToDot = true
    }
    
    func visitDot(_ dot: Dot) {
        guard let location = dot.location,
              let framesize = dot.size,
              let color = dot.color else {
            return
        }
        let x = location.x
        let y = location.y
        let frame = CGRect(x: x - framesize / 2.0, y: y - framesize / 2.0, width: framesize, height: framesize)
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: frame)
    }
}
