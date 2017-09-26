//
//  LFFit.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFFit: NSObject {

    /// 根据指定size，获取等比例height
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - size: 目标尺寸
    /// - Returns: 高度
    static func fitHeight(forWidth width: CGFloat, targetSize size: CGSize) -> CGFloat {
        return width*size.height/size.width
    }

    /// 根据指定size，获取等比例width
    ///
    /// - Parameters:
    ///   - height: 高度
    ///   - size: 目标尺寸
    /// - Returns: 宽度
    static func fitWidth(forHeight height: CGFloat, targetSize size: CGSize) -> CGFloat {
        return height*size.width/size.height
    }

    /// 调节位置（x／y坐标）
    ///
    /// - Parameters:
    ///   - original: 原始大小
    ///   - max: 最大大小
    /// - Returns: 合适的坐标值
    static func fitOrigin(original: CGFloat, max: CGFloat) -> CGFloat {
        return original > max ? 0 : (max - original)*0.5
    }

    /// 等比例压缩尺寸 至 指定范围
    ///
    /// - Parameters:
    ///   - originalSize: 原始尺寸
    ///   - targetSize: 目标尺寸
    ///   - backMax: 是否返回小于指定范围的最大大小(默认false)
    /// - Returns: 等比例压缩后的尺寸
    static func fitSize(originalSize: CGSize, targetSize: CGSize, backMax: Bool = false) -> CGSize {
        let targetW = targetSize.width
        let targetH = targetSize.height
        let maxScale = targetW*1.0/targetH
        let originalW = originalSize.width
        let originalH = originalSize.height
        let scale = originalW*1.0/originalH
        
        if scale > maxScale && originalW > targetW {
            return CGSize(width: targetW, height: targetW/scale)
        }else if scale < maxScale && originalH > targetH {
            return CGSize(width: scale*targetH, height: targetH)
        }else if scale == maxScale && originalH > targetH {
            return CGSize(width: targetW, height: targetH)
        }else {
            if backMax {
                if originalW/targetW < originalH/targetH {
                    return CGSize(width: scale*targetH, height: targetH)
                }else{
                    return CGSize(width: targetH, height: targetW/scale)
                }
            }else {
                return originalSize;
            }
        }
    }
    
    
    /// 根据宽度等比例压缩尺寸
    ///
    /// - Parameters:
    ///   - originalSize: 原始尺寸
    ///   - targetWidth: 目标宽度
    ///   - backMax: 是否返回最大尺寸(默认false)
    /// - Returns: 压缩后的尺寸
    static func fitSize(originalSize: CGSize, targetWidth: CGFloat, backMax: Bool = false) -> CGSize {
        let originalW = originalSize.width
        let originalH = originalSize.height
        if backMax || originalSize.width > targetWidth {
            return CGSize(width: targetWidth, height: targetWidth*originalH/originalW)
        }else {
            return originalSize
        }
    }
    
    /// 根据高度等比例压缩尺寸
    ///
    /// - Parameters:
    ///   - originalSize: 原始尺寸
    ///   - targetHeight: 目标高度
    ///   - backMax: 是否返回最大尺寸(默认false)
    /// - Returns: 压缩后的尺寸
    static func fitSize(originalSize: CGSize, targetHeight: CGFloat, backMax: Bool = false) -> CGSize {
        let originalW = originalSize.width
        let originalH = originalSize.height
        if backMax || originalH > targetHeight {
            return CGSize(width: targetHeight*originalW/originalH, height: targetHeight)
        }else {
            return originalSize
        }
    }
}
