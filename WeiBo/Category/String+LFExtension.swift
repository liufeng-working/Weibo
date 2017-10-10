//
//  String+LFExtension.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

let LFMatchingNSStringKey = "LFMatchingNSStringKey"
let LFMatchingNSRangKey = "LFMatchingNSRangKey"
extension String {
    func matchingWithPattern(pattern: String) -> (handleResult: [[String: Any]]?, originalResult: [NSTextCheckingResult]?) {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return (nil, nil)
        }
        
        let matcheResults = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.characters.count))
        
        var resultDics = [[String: Any]]()
        for matcheResult in matcheResults {
            let range = matcheResult.range
            let string = (self as NSString).substring(with: range)
            let resultDic = [LFMatchingNSStringKey: string, LFMatchingNSRangKey: range] as [String : Any]
            resultDics.append(resultDic)
        }
        return (resultDics, matcheResults)
    }
}
