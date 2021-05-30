//
//  ScribbleThumbnailViewImageProxy.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import UIKit

class ScribbleThumbnailViewImageProxy: ScribbleThumbnailView {
    var touchCommand: Command?
    private var realImage: UIImage?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getScribble() -> Scribble? {
        guard let scribble = self.scribble else {
            let fileManager = FileManager.default
            // 使用传过来的路径获取 Data 数据
            guard let scribbleData = fileManager.contents(atPath: self.scribblePath) else { return nil }
            // 从 这个 Data 对象 创建一个ScribbleMemento 对象
            let scribbleMemento = ScribbleMemento.memento(with: scribbleData)
            //然后使用这个备忘录，根据其中所保存的内容来恢复Scribble对象
            self.scribble = Scribble.scribble(with: scribbleMemento!)
            return self.scribble
        }
        return scribble
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        image.draw(in: rect)
    }
    
    override var image: UIImage! {
        set {}
        get {
            self.realImage = UIImage(contentsOfFile: self.imagePath)
            return self.realImage
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCommand?.execute()
    }
}
