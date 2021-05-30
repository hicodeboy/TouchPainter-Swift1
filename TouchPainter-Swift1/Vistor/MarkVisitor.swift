//
//  MarkVisitor.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import Foundation

protocol MarkVisitor {
    func visitMark(mark: Mark)
    func visitVertex(_ vertex: Vertex)
    func visitStroke(_ stroke: Stroke)
    func visitDot(_ dot: Dot)
}
