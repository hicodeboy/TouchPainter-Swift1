//
//  PaletteViewController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class PaletteViewController: UIViewController, SetStrokeColorCommandDelegate, SetStrokeSizeCommandDelegate {
    
    @IBOutlet weak var redSlider: CommandSlider!
    
    @IBOutlet weak var greenSlider: CommandSlider!
    
    @IBOutlet weak var blueSlider: CommandSlider!
    
    @IBOutlet weak var sizeSlider: CommandSlider!
    
    @IBOutlet weak var paletteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "调色板"
        
        let colorCommand = SetStrokeColorCommand()
        colorCommand.delegate = self
        
        redSlider.command = colorCommand
        greenSlider.command = colorCommand
        blueSlider.command = colorCommand
        
        let sizeCommand = SetStrokeSizeCommand()
        sizeCommand.delegate = self
        sizeSlider.command = sizeCommand
        
        // 数据持久化
        let userDefaults = UserDefaults.init()
        let redValue = userDefaults.float(forKey: "red")
        let greenValue = userDefaults.float(forKey: "green")
        let blueValue = userDefaults.float(forKey: "blue")
        let sizeValue = userDefaults.float(forKey: "size")
        
        self.redSlider.value = redValue
        self.greenSlider.value = greenValue
        self.blueSlider.value = blueValue
        self.sizeSlider.value = sizeValue
        
        let color = UIColor(red: CGFloat(redValue),
                            green: CGFloat(greenValue),
                            blue: CGFloat(blueValue), alpha: 1.0)
        
        self.paletteView.backgroundColor = color
    }
    
    
    func command(_ command: SetStrokeSizeCommand, size: inout Float) {
        
    }
    
    func command(command: SetStrokeColorCommand, red: inout Float, green: inout Float, blue: inout Float) {
        
    }
    
    func command(command: SetStrokeColorCommand, color: UIColor) {
        
    }
}
