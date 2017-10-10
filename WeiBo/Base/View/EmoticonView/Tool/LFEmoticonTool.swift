//
//  LFEmoticonTool.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFEmoticonTool: NSObject {
    public static func insertEmoticonIntoTextView(textView: UITextView, emoticon: LFEmoticon) {
        if emoticon.isEmpty {
            
        }else if emoticon.isRemove {
            textView.deleteBackward()
        }else if emoticon.emoji != "" {
            let rang = textView.selectedTextRange!
            textView.replace(rang, withText: emoticon.emoji)
        }else {
            let attachment = LFTextAttachment()
            attachment.chs = emoticon.chs
            attachment.image = UIImage(contentsOfFile: emoticon.pngPath)
            let font = textView.font!
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attStr = NSAttributedString(attachment: attachment)
            
            let attMStr = NSMutableAttributedString(attributedString: textView.attributedText)
            let rang = textView.selectedRange
            attMStr.replaceCharacters(in: rang, with: attStr)
            
            textView.attributedText = attMStr
            
            textView.font = font
            textView.selectedRange = NSRange(location: rang.location + 1, length: rang.length)
        }
    }
    
    public static func getAttributeString(textView: UITextView) -> NSAttributedString {
        let attMStr = NSMutableAttributedString(attributedString: textView.attributedText)
        attMStr.enumerateAttributes(in: NSRange(location: 0, length: attMStr.length), options: []) { (dict, rang, _) in
            if let attachment = dict["NSAttachment"] as? LFTextAttachment {
                attMStr.replaceCharacters(in: rang, with: attachment.chs!)
            }
        }
        return attMStr
    }
    
    public static func showEmoticonAtLable(label: UILabel) -> NSAttributedString? {
        let pattern = "\\[.+?\\]"
        
        guard let text = label.text else {
            return nil
        }
        guard let attributedText = label.attributedText else {
            return nil
        }
        guard let resultDics = text.matchingWithPattern(pattern: pattern).handleResult else {
            return nil
        }
        
        let attMStr = NSMutableAttributedString(string: text)
        for dict in resultDics.reversed() {
            let chs = dict[LFMatchingNSStringKey] as! String
            
            guard let pngPath = self.findPngPath(chs: chs) else {
                continue
            }
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: label.font.lineHeight, height: label.font.lineHeight)
            let rang = dict[LFMatchingNSRangKey] as! NSRange
            let attStr = NSAttributedString(attachment: attachment)
            attMStr.replaceCharacters(in: rang, with: attStr)
        }
        return attMStr
    }
}

//MARK: - 私有方法
extension LFEmoticonTool {
    fileprivate static func findPngPath(chs: String) -> String? {
        for package in LFEmoticonManager.shareManager.packages {
            for emoticon in package.emoticons {
                if emoticon.chs == chs {
                    return emoticon.pngPath
                }
            }
        }
        
        return nil
    }
}
