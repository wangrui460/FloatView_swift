//
//  ViewController.swift
//  FloatViewDemo
//
//  Created by wangrui on 2017/3/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .plain)
    fileprivate var floatView:FloatView?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.delegate = self
        // 创建方式一：
//        let floatView = FloatView(image: UIImage(named: "FloatBonus"))
        
        // 创建方式二：
        floatView = FloatView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        floatView?.image = UIImage(named: "FloatBonus")
        floatView?.stayMode = .STAYMODE_LEFTANDRIGHT
        floatView?.setTapActionWithBlock {
            print("点击了浮动图片。。。")
        }
        if let floatV = floatView {
            view.addSubview(floatV)
        }
    }
}

extension ViewController: UITableViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        floatView?.moveTohalfInScreen()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        floatView?.setCurrentAlpha(curAlpha: 0.5)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        floatView?.setCurrentAlpha(curAlpha: 1.0)
    }
}




