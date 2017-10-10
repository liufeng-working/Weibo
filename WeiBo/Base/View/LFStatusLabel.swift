//
//  LFStatusLabel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//  微博label，用于识别 用户、话题、链接

import UIKit

enum LFTapHandlerType : Int {
    case none  //无
    case user  //用户
    case topic //话题
    case link  //链接
}

class LFStatusLabel: UILabel {

    //MARK: - 重写属性
    override var text: String? {
        didSet {
            self.prepareText()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            self.prepareText()
        }
    }
    
    override var font: UIFont! {
        didSet {
            self.prepareText()
        }
    }
    
    override var textColor: UIColor! {
        didSet {
            self.prepareText()
        }
    }
    
    var matchTextColor: UIColor = UIColor(red: 87 / 255.0, green: 196 / 255.0, blue: 251 / 255.0, alpha: 1.0) {
        didSet {
            self.prepareText()
        }
    }
    
    //MARK: - 懒加载属性
    fileprivate lazy var textStorage: NSTextStorage = NSTextStorage() // NSMutableAttributeString的子类
    fileprivate lazy var layoutManager: NSLayoutManager = NSLayoutManager() // 布局管理者
    fileprivate lazy var textContainer: NSTextContainer = NSTextContainer() // 容器,需要设置容器的大小
    
    // 用于记录下标值
    fileprivate lazy var linkRanges: [NSRange] = [NSRange]()
    fileprivate lazy var userRanges: [NSRange] = [NSRange]()
    fileprivate lazy var topicRanges: [NSRange] = [NSRange]()
    
    // 用于记录用户选中的range
    fileprivate var selectedRange: NSRange?
    
    // 用户记录点击还是松开
    fileprivate var isSelected: Bool = false
    
    // 闭包属性,用于回调
    fileprivate var tapHandlerType: LFTapHandlerType = LFTapHandlerType.none
    
    typealias LFTapHandler = (LFStatusLabel, String, NSRange) -> Void
    var linkTapHandler: LFTapHandler?
    var topicTapHandler: LFTapHandler?
    var userTapHandler: LFTapHandler?
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepareTextSystem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.prepareTextSystem()
    }
    
    // MARK:- 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置容器的大小为Label的尺寸
        self.textContainer.size = frame.size
    }
    
    // MARK:- 重写drawTextInRect方法
    override func drawText(in rect: CGRect) {
        // 1.绘制背景
        if self.selectedRange != nil {
            // 2.0.确定颜色
            let selectedColor = self.isSelected ? UIColor(white: 0.7, alpha: 0.2) : UIColor.clear
            
            // 2.1.设置颜色
            self.textStorage.addAttribute(NSBackgroundColorAttributeName, value: selectedColor, range: self.selectedRange!)
            
            // 2.2.绘制背景
            self.layoutManager.drawBackground(forGlyphRange: self.selectedRange!, at: CGPoint(x: 0, y: 0))
        }
        
        // 2.绘制字形
        // 需要绘制的范围
        let range = NSRange(location: 0, length: self.textStorage.length)
        self.layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint.zero)
    }
}

extension LFStatusLabel {
    
    /// 准备文本系统
    fileprivate func prepareTextSystem() {
        // 0.准备文本
        self.prepareText()
        
        // 1.将布局添加到storeage中
        self.textStorage.addLayoutManager(self.layoutManager)
        
        // 2.将容器添加到布局中
        self.layoutManager.addTextContainer(self.textContainer)
        
        // 3.让label可以和用户交互
        self.isUserInteractionEnabled = true
        
        // 4.设置间距为0
        self.textContainer.lineFragmentPadding = 0
    }
    
    /// 准备文本
    fileprivate func prepareText() {
        // 1.准备字符串
        var attrString : NSAttributedString?
        if self.attributedText != nil {
            attrString = self.attributedText
        } else if self.text != nil {
            attrString = NSAttributedString(string: self.text!)
        } else {
            attrString = NSAttributedString(string: "")
        }
        
        self.selectedRange = nil
        
        // 2.设置换行模型
        let attrStringM = self.addLineBreak(attrString: attrString!)
        
        attrStringM.addAttribute(NSFontAttributeName, value: self.font, range: NSRange(location: 0, length: attrStringM.length))
        
        // 3.设置textStorage的内容
        self.textStorage.setAttributedString(attrStringM)
        
        // 4.匹配URL
        if let linkRanges = self.getLinkRanges() {
            self.linkRanges = linkRanges
            for range in linkRanges {
                self.textStorage.addAttribute(NSForegroundColorAttributeName, value: self.matchTextColor, range: range)
            }
        }
        
        // 5.匹配@用户
        if let userRanges = self.getRanges(pattern: "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*") {
            self.userRanges = userRanges
            for range in userRanges {
                textStorage.addAttribute(NSForegroundColorAttributeName, value: self.matchTextColor, range: range)
            }
        }
        
        
        // 6.匹配话题##
        if let topicRanges = self.getRanges(pattern: "#.*?#") {
            self.topicRanges = topicRanges
            for range in topicRanges {
                self.textStorage.addAttribute(NSForegroundColorAttributeName, value: self.matchTextColor, range: range)
            }
        }
        
        setNeedsDisplay()
    }
}

// MARK:- 字符串匹配封装
extension LFStatusLabel {
    fileprivate func getRanges(pattern: String) -> [NSRange]? {
        // 创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        return self.getRangesFromResult(regex: regex)
    }
    
    fileprivate func getLinkRanges() -> [NSRange]? {
        // 创建正则表达式
        guard let detector = try? NSDataDetector(types: NSTextCheckingAllTypes) else {
            return nil
        }
        
        return self.getRangesFromResult(regex: detector)
    }
    
    fileprivate func getRangesFromResult(regex : NSRegularExpression) -> [NSRange] {
        // 1.匹配结果
        let results = regex.matches(in: self.textStorage.string, options: [], range: NSRange(location: 0, length: self.textStorage.length))
        
        // 2.遍历结果
        var ranges = [NSRange]()
        for res in results {
            ranges.append(res.range)
        }
        
        return ranges
    }
}

// MARK:- 点击交互的封装
extension LFStatusLabel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 0.记录点击
        self.isSelected = true
        
        // 1.获取用户点击的点
        let selectedPoint = touches.first?.location(in: self)
        // 2.获取该点所在的字符串的range
        self.selectedRange = self.getSelectRange(selectedPoint: selectedPoint!)
        
        // 3.是否处理了事件
        if self.selectedRange == nil {
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.selectedRange == nil {
            super.touchesBegan(touches, with: event)
            return
        }
        
        // 0.记录松开
        self.isSelected = false
        
        // 2.重新绘制
        setNeedsDisplay()
        
        // 3.取出内容
        let contentText = (self.textStorage.string as NSString).substring(with: self.selectedRange!)
        
        // 3.回调
        switch tapHandlerType {
        case .link:
            if self.linkTapHandler != nil {
                self.linkTapHandler!(self, contentText, self.selectedRange!)
            }
        case .topic:
            if self.topicTapHandler != nil {
                self.topicTapHandler!(self, contentText, self.selectedRange!)
            }
        case .user:
            if self.userTapHandler != nil {
                self.userTapHandler!(self, contentText, self.selectedRange!)
            }
        default:
            break
        }
    }
    
    fileprivate func getSelectRange(selectedPoint: CGPoint) -> NSRange? {
        // 0.如果属性字符串为nil,则不需要判断
        if self.textStorage.length == 0 {
            return nil
        }
        
        // 1.获取选中点所在的下标值(index)
        let index = self.layoutManager.glyphIndex(for: selectedPoint, in: self.textContainer)
        
        // 2.判断下标在什么内
        // 2.1.判断是否是一个链接
        for linkRange in self.linkRanges {
            if index > linkRange.location && index < linkRange.location + linkRange.length {
                setNeedsDisplay()
                self.tapHandlerType = LFTapHandlerType.link
                return linkRange
            }
        }
        
        // 2.2.判断是否是一个@用户
        for userRange in self.userRanges {
            if index > userRange.location && index < userRange.location + userRange.length {
                setNeedsDisplay()
                self.tapHandlerType = LFTapHandlerType.user
                return userRange
            }
        }
        
        // 2.3.判断是否是一个#话题#
        for topicRange in self.topicRanges {
            if index > topicRange.location && index < topicRange.location + topicRange.length {
                setNeedsDisplay()
                self.tapHandlerType = LFTapHandlerType.topic
                return topicRange
            }
        }
        
        return nil
    }
}

// MARK:- 补充
extension LFStatusLabel {
    /// 如果用户没有设置lineBreak,则所有内容会绘制到同一行中,因此需要主动设置
    fileprivate func addLineBreak(attrString: NSAttributedString) -> NSMutableAttributedString {
        let attrStringM = NSMutableAttributedString(attributedString: attrString)
        
        if attrStringM.length == 0 {
            return attrStringM
        }
        
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributes(at: 0, effectiveRange: &range)
        var paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle
        
        if paragraphStyle != nil {
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
        } else {
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
            
            attrStringM.setAttributes(attributes, range: range)
        }
        
        return attrStringM
    }
}
