//
//  FloatView.swift
//  FloatViewDemo
//
//  Created by wangrui on 2017/3/23.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

/// 类似OC的宏定义#define,前面加上fileprivate表示只在本文件中有效
fileprivate let NavBarBottom:CGFloat  = 64.0
fileprivate let TabBarHeight:CGFloat  = 49.0
fileprivate let kScreenWidth  = UIScreen.main.bounds.width
fileprivate let kScreenHeight = UIScreen.main.bounds.height

class FloatView: UIImageView
{
    var stayEdgeDistance:CGFloat = 5
    fileprivate let stayAnimateTime = 0.3
    
    override init(image: UIImage?)
    {
        super.init(image: image)
        isUserInteractionEnabled = true
        moveToInitialLocation()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        moveToInitialLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置浮动图片的初始位置
    func moveToInitialLocation()
    {
        var frame = self.frame
        let stayWidth = frame.width
        let initX = kScreenWidth - stayEdgeDistance - stayWidth
        let initY = (kScreenHeight - NavBarBottom - TabBarHeight) * (2.0 / 3.0) + NavBarBottom
        frame.origin.x = initX
        frame.origin.y = initY
        self.frame = frame
    }
}


// MARK: - getter / setter
extension FloatView
{
    
    /// 重写image的set方法
    override var image: UIImage? {
        didSet {
            self.sizeToFit()
            moveToInitialLocation()
        }
    }
}



