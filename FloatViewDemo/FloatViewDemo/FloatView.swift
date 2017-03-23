//
//  FloatView.swift
//  FloatViewDemo
//
//  Created by wangrui on 2017/3/23.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

/// 类似OC的宏定义#define,前面加上fileprivate表示只在本文件中有效
fileprivate let NavBarBottom = 64
fileprivate let TabBarHeight = 49

class FloatView: UIImageView
{
    override init(image: UIImage?)
    {
        super.init(image: image)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
