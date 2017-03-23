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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 创建方式一：
//        let floatView = FloatView(image: UIImage(named: "FloatBonus"))
        
        // 创建方式二：
        let floatView = FloatView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        floatView.image = UIImage(named: "FloatBonus")
        view.addSubview(floatView)
    }
}

