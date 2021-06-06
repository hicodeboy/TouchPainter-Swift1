//
//  CanvasViewController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class CanvasViewController: UIViewController {
    var canvasView: CanvasView!
    
    var scribble: Scribble?   // 涂鸦对象
    var strokeColor: UIColor! // 划线的颜色
    var strokeSize: CGFloat!  // 线段粗细
    var startPoint: CGPoint!
    
    @IBOutlet weak var trashBarButton: CommandBarButton!
    
    @IBOutlet weak var saveBarButton: CommandBarButton!
    
    @IBOutlet weak var undoBarButton: CommandBarButton!
    
    @IBOutlet weak var redoBarButton: CommandBarButton!
    
    let _undoManager: UndoManager = UndoManager()
    
    var undoT: UndoType = .none
    
    
    var scribleInvocation: ScribleInvocation = ScribleInvocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trashBarButton.command = DeleteScribbleCommand()
        saveBarButton.command = SaveScribbleCommand()
        
        // 设置中介者画板对象
        CoordinatingController.instance.canvasViewController = self
        let defaultGenerator = CanvasViewGenerator()
        
        loadCanvasView(with: defaultGenerator)
        let scribble = Scribble()
        self.setScribble(scribble)
        loadSizeAndColor()
    }
    
    func setScribble(_ scribble: Scribble) {
        if (self.scribble != scribble) {
            self.scribble = scribble
            self.scribble?.addObserver(self, forKeyPath: "mark", options: [.initial,.new], context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change else { return }
        let mark = change[.newKey]
        self.canvasView.mark = mark as? Mark
        self.canvasView.setNeedsDisplay()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startPoint = touches.first?.location(in: canvasView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let lastPoint = touches.first?.previousLocation(in: canvasView) {
            if lastPoint.equalTo(startPoint) {
                let newStroke = Stroke()
                newStroke.color = strokeColor
                newStroke.size = strokeSize
                scribble?.add(mark: newStroke, shouldAddToPreviousMark: false)
                drawScribleInvocation { (invocation) in
                    invocation.mark = newStroke
                }
            }
            guard let thisPoint = touches.first?.location(in: canvasView) else { return }
            let vectex = Vertex(with: thisPoint)
            scribble?.add(mark: vectex, shouldAddToPreviousMark: true)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let lastPoint = touches.first?.preciseLocation(in: canvasView),
              let thisPoint = touches.first?.location(in: canvasView),
              let scribble = scribble else { return }
        if lastPoint.equalTo(thisPoint) {
            let singleDot = Dot(with: thisPoint)
            singleDot.color = strokeColor
            singleDot.size = strokeSize
            scribble.add(mark: singleDot, shouldAddToPreviousMark: false)
            drawScribleInvocation { (invocation) in
                invocation.mark = singleDot
            }
        }
        startPoint = .zero
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        startPoint = .zero
    }
    
    @IBAction func toolBarAction(_ sender: CommandBarButton) {
        switch sender.tag {
        case 1:
            fallthrough
        case 2:
            sender.command?.execute()
        case 5:
            self.undoT = .undo
            self.undoManager.undo()
        case 6:
            self.undoT = .redo
            self.undoManager.redo()
        default:
            print("\(sender.tag)")
        }
        
    }
    func loadSizeAndColor() {
        let userDefaults = UserDefaults.init()
        let redValue = userDefaults.float(forKey: "red")
        let greenValue = userDefaults.float(forKey: "green")
        let blueValue = userDefaults.float(forKey: "blue")
        let sizeValue = userDefaults.float(forKey: "size")
        
        let color = UIColor(red: CGFloat(redValue),
                            green: CGFloat(greenValue),
                            blue: CGFloat(blueValue), alpha: 1.0)
        
        self.strokeSize = CGFloat(sizeValue == 0 ? 5 : sizeValue)
        self.strokeColor = color
    }
    
    func loadCanvasView(with generator: CanvasViewGenerator) {
        canvasView?.removeFromSuperview()
        let aFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64)
        let aCanvasView = generator.canvasView(with: aFrame)

        self.canvasView = aCanvasView
//        self.canvasView.backgroundColor = .red
        let viewIndex = self.view.subviews.count - 1
        
        self.view.insertSubview(self.canvasView ?? aCanvasView, at: viewIndex)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// 将要显示时将导航条隐藏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// 将要消失时将导航条显示
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension CanvasViewController {
    enum UndoType {
        case none
        case undo
        case redo
    }
    
    override var undoManager: UndoManager {
        return _undoManager
    }
    
    func drawScribleInvocation(_ mutations: (inout ScribleInvocation) -> Void) {
        guard let scrible = scribble else { return }
        let oldInvocation = scribleInvocation
        mutations(&scribleInvocation)
        let model = oldInvocation.action(undo: scribleInvocation)
        scribleInvocation = model.undo
        undoManager.registerUndo(withTarget: self) { (target) in
            switch (self.undoT) {
            case .none:
                print("none")
            case .undo:
                model.undo.undo(with: scrible)
            case .redo:
                model.redo.redo(with: scrible)
            }
            target.drawScribleInvocation { (m) in
                m = model.undo
            }
        }
        DispatchQueue.main.async {
            self.redoBarButton.isEnabled = self.undoManager.canRedo
            self.undoBarButton.isEnabled = self.undoManager.canUndo
        }
        
        
    }
}
