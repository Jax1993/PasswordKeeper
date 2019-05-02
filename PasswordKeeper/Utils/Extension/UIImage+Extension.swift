//
//  UIImage+Extension.swift
//  Jax
//
//  Created by wangjh on 2018/4/11.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(with color: UIColor) -> UIImage {
        let pixelScale = UIScreen.main.scale
        let pixelSize = 1 / pixelScale
        let fillSize = CGSize(width: pixelSize, height: pixelSize)
        let fillRect = CGRect(origin: CGPoint.zero, size: fillSize)
        UIGraphicsBeginImageContextWithOptions(fillRect.size, false, pixelScale)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext!.setFillColor(color.cgColor)
        graphicsContext!.fill(fillRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func image(char: String, font: UIFont = UIFont.boldSystemFont(ofSize: 26), color: UIColor = UIColor.white) -> UIImage {
        let imgWidth = 100.0
        let bgColor = FZColor.themeBlueColor
        let strWidth = char.width(withConstrainedHeight: CGFloat(imgWidth), font: font)
        let strHeight = char.height(withConstrainedWidth: CGFloat(imgWidth), font: font)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: strWidth, height: strHeight))
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            let attrs = [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: color,
                         NSAttributedString.Key.backgroundColor:bgColor]
            char.draw(with: CGRect(x: 0, y: 0, width: imgWidth, height: imgWidth), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        return img
    }
    
    class func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
