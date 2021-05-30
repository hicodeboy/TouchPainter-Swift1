//
//  ScribbleThumbnailView.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import UIKit

class ScribbleThumbnailView: UIView, ScribbleSource {
    func getScribble() -> Scribble? {
        return nil
    }
    
    var scribble: Scribble?
    
    var image: UIImage!
    var imagePath: String!
    var scribblePath: String!
    
}
