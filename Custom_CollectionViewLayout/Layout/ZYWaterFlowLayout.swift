//
//  ZYWaterFlowLayout.swift
//  Custom_CollectionViewLayout
//
//  Created by 王志盼 on 2017/4/18.
//  Copyright © 2017年 王志盼. All rights reserved.
//  瀑布流布局

import UIKit

class ZYWaterFlowLayout: UICollectionViewLayout {
    
    fileprivate var style: ZYWaterFlowStyle
    
    /// 记录每一列最大的Y值
    fileprivate lazy var maxYDict: [String: NSNumber] = [:]
    
    //保存所以的attributes属性，优化性能、防止多次计算
    fileprivate lazy var allAttributes: [UICollectionViewLayoutAttributes] = []
    
    init(style: ZYWaterFlowStyle) {
        self.style = style
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepare() {
        super.prepare()
        
        
    }
    
}
