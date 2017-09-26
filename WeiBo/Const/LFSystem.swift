//
//  LFSystem.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

//MARK: - 主程序
let lfApp = UIApplication.shared.delegate as! AppDelegate

//MARK: - 主窗口
let lfWindow = lfApp.window!

//MARK: - 屏幕宽高
let lfScreenWidth = (UIScreen.main.bounds.width)
let lfScreenHeight = (UIScreen.main.bounds.height)

//MARK: - 沙盒路径
let lfHomePath = NSHomeDirectory()
let lfDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
let lfCachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
let lfTemPath = NSTemporaryDirectory()
