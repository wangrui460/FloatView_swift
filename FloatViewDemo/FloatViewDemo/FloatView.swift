//
//  FloatView.swift
//  FloatViewDemo
//
//  Created by wangrui on 2017/3/23.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

fileprivate let kTapGentureKey       = UnsafeRawPointer(bitPattern: "kTapGentureKey".hashValue)
fileprivate let kTapGentureActionKey = UnsafeRawPointer(bitPattern: "kTapGentureActionKey".hashValue)

/// 类似OC的宏定义#define,前面加上fileprivate表示只在本文件中有效
fileprivate let NavBarBottom:CGFloat  = 64.0
fileprivate let TabBarHeight:CGFloat  = 49.0
fileprivate let kScreenWidth  = UIScreen.main.bounds.width
fileprivate let kScreenHeight = UIScreen.main.bounds.height

enum StayMode {
    // 停靠左右两侧
    case STAYMODE_LEFTANDRIGHT
    // 停靠左侧
    case STAYMODE_LEFT
    // 停靠右侧
    case STAYMODE_RIGHT
}

class FloatView: UIImageView
{
    var stayMode:StayMode = .STAYMODE_LEFTANDRIGHT
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
    
    func setCurrentAlpha(curAlpha:CGFloat)
    {
        var curAlp = curAlpha
        if (curAlpha <= 0) {
            curAlp = 1
        }
        alpha = curAlp
    }
}


// MARK: - 移动相关方法
extension FloatView
{
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
    
    /// 当滚动的时候悬浮图片居中在屏幕边缘
    func moveTohalfInScreen()
    {
        let isLeft = judgeLocationIsLeft()
        moveStayToMiddleInScreenBorder(isLeft: isLeft)
    }
    
    func moveStayToMiddleInScreenBorder(isLeft:Bool)
    {
        var frame = self.frame;
        let stayWidth = frame.size.width;
        var destinationX:CGFloat;
        if (isLeft == true) {
            destinationX = -stayWidth/2;
        }
        else {
            destinationX = kScreenWidth - stayWidth + stayWidth/2;
        }
        frame.origin.x = destinationX;
        UIView.animate(withDuration: TimeInterval(0.2), animations: { [weak self] in
            self?.frame = frame
        })
    }
    
    /// 根据stayMode来移动浮动图片
    func moveFloatView()
    {
        switch stayMode
        {
        case .STAYMODE_LEFTANDRIGHT:
            let isLeft = judgeLocationIsLeft()
            moveToBorder(isLeft: isLeft)
        case .STAYMODE_LEFT:
            moveToBorder(isLeft: true)
        case .STAYMODE_RIGHT:
            moveToBorder(isLeft: false)
        }
    }
    
    /// 移动到屏幕边缘
    func moveToBorder(isLeft:Bool)
    {
        var frame = self.frame
        let stayWidth = frame.width
        var borderX:CGFloat = 0
        if (isLeft == true) {
            borderX = stayEdgeDistance
        } else {
            borderX = kScreenWidth - stayEdgeDistance - stayWidth
        }
        let curY = moveSafeLocationY()
        frame.origin.x = borderX
        frame.origin.y = curY
        UIView.animate(withDuration: TimeInterval(0.5)) { [weak self] in
            self?.frame = frame
        }
    }
    
    func judgeLocationIsLeft() -> Bool
    {
        // 手机屏幕中间位置x值
        let middleX = UIScreen.main.bounds.size.width / 2.0
        // 当前view的x值
        let curX = self.frame.origin.x + self.bounds.width/2
        if (curX <= middleX) {
            return true
        } else {
            return false
        }
    }
    
    /// 保证垂直方向不在导航栏以上或者tabBar以下
    func moveSafeLocationY() -> CGFloat
    {
        let frame = self.frame
        let stayHeight = frame.size.height
        // 当前view的y值
        let curY = frame.origin.y
        var destinationY = curY
        // 悬浮图片的最顶端Y值
        let stayMostTopY = NavBarBottom + stayEdgeDistance
        if (curY <= stayMostTopY) {
            destinationY = stayMostTopY
        }
        // 悬浮图片的底端Y值
        let stayMostBottomY = kScreenHeight - TabBarHeight - stayEdgeDistance - stayHeight
        if (curY >= stayMostBottomY) {
            destinationY = stayMostBottomY
        }
        return destinationY
    }
}

// MARK: - 轻点事件
extension FloatView
{
    func setTapActionWithBlock(tapBlock:(()->()))
    {
        let tapGesture = objc_getAssociatedObject(self, kTapGentureKey)
        if (tapGesture == nil)
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickFloatView))
            self.addGestureRecognizer(tapGesture)
            objc_setAssociatedObject(self, kTapGentureKey, tapGesture, .OBJC_ASSOCIATION_RETAIN)
        }
        objc_setAssociatedObject(self, kTapGentureActionKey, (tapBlock as AnyObject) , .OBJC_ASSOCIATION_COPY)
    }
    
    func onClickFloatView(tapGesture:UITapGestureRecognizer)
    {
        if (tapGesture.state == UIGestureRecognizerState.recognized)
        {
            if let tapBlock = objc_getAssociatedObject(self, kTapGentureActionKey) as? (()->())
            {
                tapBlock()
            }
        }
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


// MARK: - touchesMoved、touchesEnded
extension FloatView
{
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        for touch:AnyObject in touches
        {
            if (touch.isKind(of: UITouch.self))
            {
                let curPoint = touch.location(in: self)
                let prePoint = touch.previousLocation(in: self)
                let moveX = curPoint.x - prePoint.x
                let moveY = curPoint.y - prePoint.y
                var frame = self.frame
                frame.origin.x += moveX
                frame.origin.y += moveY
                self.frame = frame
                return
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        moveFloatView()
    }
}



