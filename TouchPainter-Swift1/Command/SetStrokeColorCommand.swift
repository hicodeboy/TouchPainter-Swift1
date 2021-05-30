//
//  SetStrokeColorCommand.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

typealias RGBValuesProvider = (_ red: inout Float, _ green: inout Float, _ blue: inout Float) -> Void


typealias PostColorUpdateProvider = (_ color: UIColor) -> Void

protocol SetStrokeColorCommandDelegate: class {
    func command(command: SetStrokeColorCommand,
                 red: inout Float,
                 green: inout Float,
                 blue: inout Float)
    func command(command: SetStrokeColorCommand, color: UIColor)
}

class SetStrokeColorCommand: Command {
    weak var delegate: SetStrokeColorCommandDelegate?
    
    var rgbValuesProvider: RGBValuesProvider?
    var postColorUpdateProvider: PostColorUpdateProvider?
    
    override func execute() {
        var redValue: Float = 0.0
        var greenValue: Float = 0.0
        var blueValue: Float = 0.0
        
        delegate?.command(command: self, red: &redValue, green: &greenValue, blue: &blueValue)
        
        let color: UIColor = UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1.0)
        delegate?.command(command: self, color: color)
        
        // TODO 给canvasVC传值
        let coordinator = CoordinatingController.instance
        let controller = coordinator.canvasViewController
        controller?.strokeColor = color
    }
}
