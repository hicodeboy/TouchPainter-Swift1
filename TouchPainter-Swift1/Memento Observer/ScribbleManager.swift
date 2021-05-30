//
//  ScribbleManager.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import UIKit

class ScribbleManager {
    let kScribbleDataPath = NSHomeDirectory().appending("/Documents/data")
    let kScribbleThumbnailPath = NSHomeDirectory().appending("/Documents/thumbnails")
    
    func save(scribble: Scribble, thumbnail: UIImage) {
        let newIndex = self.numberOfScribbles() + 1
        let scribbleDataName = "data_\(newIndex)"
        let scribbleThumbnailName = "thumbnail_\(newIndex).png"
        // 从涂鸦对象 获取备忘录对象
        
        let scribbleMemento = scribble.scribbleMemento()
        // 从备忘录对象取得NSData对象，之后保存到文件系统中
        let mementoData = scribbleMemento?.data()
        // 构建保存路径
        let mementoPath: String = "\(String(describing: self.scribbleDataPath() ?? ""))/\(scribbleDataName)"

        let imageData = thumbnail.pngData()
        let imagePath: String = "\(String(describing: self.scribbleThumbnailPath() ?? ""))/\(scribbleThumbnailName)"
        
        do {
            try mementoData?.write(to: URL(fileURLWithPath: mementoPath))
        } catch {
            print("保存 归档数据失败")
        }
        
        do {
            try imageData?.write(to: URL(fileURLWithPath: imagePath))
        } catch {
            print("保存 图片数据失败")
        }
    }
    
    // 涂鸦的数量总和
    func numberOfScribbles() -> Int {
        return self.scribbleDataPaths()?.count ?? 0
    }
    
    // MARK: Private
    // 获取Data 数据路径集合
    private func scribbleDataPaths() -> Array<String>? {
        return scribblePaths(with: self.scribbleDataPath())
    }
    
    // 获取缩略图路径集合
    private func scribbleThumbnailPaths() -> Array<String>? {
        return scribblePaths(with: self.scribbleThumbnailPath())
    }
    
    // 获取单个Data路径
    private func scribbleDataPath() -> String? {
        return scribblePath(kScribbleDataPath)
    }
    
    // 获取单个缩略图路径
    private func scribbleThumbnailPath() -> String? {
        return scribblePath(kScribbleThumbnailPath)
    }
    
    // 获取路径下文件集合
    private func scribblePaths(with path: String?) -> Array<String>? {
        guard let path = path else {
            return nil
        }
        let fileManager = FileManager.default
        do {
            var scribbleThumbnailPathsArray = try fileManager.contentsOfDirectory(atPath: path)
            scribbleThumbnailPathsArray.sort()
            return scribbleThumbnailPathsArray
        } catch {
            return nil
        }
    }
    
    // 获取单个路径
    private func scribblePath(_ path: String) -> String? {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return path
    }
}
