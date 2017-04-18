//
//  ZYWaterFlowLayout.swift
//  Custom_CollectionViewLayout
//
//  Created by 王志盼 on 2017/4/18.
//  Copyright © 2017年 王志盼. All rights reserved.
//  瀑布流布局

import UIKit

protocol ZYWaterFlowLayoutDelegate: class {
    func waterFlowLayout(_ waterFlowLayout: ZYWaterFlowLayout, heightForCellAt indexPath: IndexPath) -> CGFloat
}

class ZYWaterFlowLayout: UICollectionViewLayout {
    
    weak var delegate: ZYWaterFlowLayoutDelegate?
    
    fileprivate var style: ZYWaterFlowStyle
    
    /// 记录每一列最大的Y值
    fileprivate lazy var maxYDict: [String: CGFloat] = [:]
    
    //保存所以的attributes属性，优化性能、防止多次计算
    fileprivate lazy var allAttributes: [UICollectionViewLayoutAttributes] = []
    
    init(style: ZYWaterFlowStyle) {
        self.style = style
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 只要显示的边界发生改变就重新布局:
    /// 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
    
    
    /// 在这里，初始化maxYDict、allAttributes
    override func prepare() {
        super.prepare()
        
        //清空最大Y值
        for i in 0..<style.columnsCount {
            maxYDict["\(i)"] = style.sectionInsets.top
        }
        
        //重新获取所有的attribute
        allAttributes.removeAll()
        let count = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<count {
            let oattribute = self.layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            guard let attribute = oattribute else {
                continue
            }
            allAttributes.append(attribute)
        }
    }
    
    //设置contentSize
    override var collectionViewContentSize: CGSize {
        
        var maxYColumn = "0"
        for (key, value) in maxYDict {
            if value > maxYDict[maxYColumn] ?? 0 {
                maxYColumn = key
            }
        }
        return CGSize(width: 0, height: maxYDict[maxYColumn]! + style.sectionInsets.bottom)
    }
    
    /// 返回indexPath这个位置Item的布局属性
    ///
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        //得到高度最小的那一行
        var minYColumn = "0"
        for (key, value) in maxYDict {
            if value < (maxYDict[minYColumn] ?? CGFloat(MAXFLOAT)){
                minYColumn = key
            }
        }
        
        let columnsCount = CGFloat(style.columnsCount)
        let width = (collectionView!.frame.size.width - style.sectionInsets.left - style.sectionInsets.right - (columnsCount - 1) * style.columnMargin) / columnsCount;
        
        let height = self.delegate?.waterFlowLayout(self, heightForCellAt: indexPath) ?? 0
        
        let x = style.sectionInsets.left + (width + style.columnMargin) * CGFloat(Int(minYColumn)!);
        let y = maxYDict[minYColumn]! + style.rowMargin
        
        maxYDict[minYColumn] = y + height
        
        //创建属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.frame = CGRect(x: x, y: y, width: width, height: height)
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return allAttributes
    }
}
