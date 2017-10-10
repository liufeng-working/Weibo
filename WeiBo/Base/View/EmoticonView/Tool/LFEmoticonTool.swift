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
}
