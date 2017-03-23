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
        let floatView = FloatView(image: UIImage(named: "FloatBonus"))
        view.addSubview(floatView)
    }
}

