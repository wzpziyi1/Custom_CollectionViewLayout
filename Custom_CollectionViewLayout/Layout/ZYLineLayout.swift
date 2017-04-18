//
//  ZYLineLayout.swift
//  Custom_CollectionViewLayout
//
//  Created by 王志盼 on 2017/4/17.
//  Copyright © 2017年 王志盼. All rights reserved.
//  横向滚动放大的布局

import UIKit

class ZYLineLayout: UICollectionViewFlowLayout {

    fileprivate var itemW: CGFloat
    fileprivate var itemH: CGFloat
    
    init(itemW: CGFloat, itemH: CGFloat) {
        
        self.itemW = itemW
        self.itemH = itemH
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /// 只要显示的边界发生改变就重新布局:
    /// 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    /// 在这个方法里面做初始化的工作
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: itemW, height: itemH)
        scrollDirection = .horizontal
        self.minimumLineSpacing = 70
        
        self.sectionInset = UIEdgeInsetsMake(0, collectionView!.bounds.width * 0.5, 0, collectionView!.bounds.width * 0.5)
    }
    
    
    /// 当停止滚动的时候，重新设置最近的cell处于屏幕中间
    ///
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        //当前屏幕可见范围
        let visibleRect : CGRect = CGRect(origin: proposedContentOffset, size: collectionView!.bounds.size)
        
        
        /// 拿到当前可见cells的attributes
        let oallAttributes = layoutAttributesForElements(in: visibleRect)
        var minMargin = CGFloat(MAXFLOAT)
        let centerX = proposedContentOffset.x + 0.5 * collectionView!.bounds.width
        
        guard let allAttributes = oallAttributes else {
            return proposedContentOffset
        }
        
        for (_, attribute) in allAttributes.enumerated() {
            
            if abs(attribute.center.x - centerX) < abs(minMargin) {
                minMargin = attribute.center.x - centerX
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + minMargin, y: proposedContentOffset.y)
    }
    
    ///
    /// - Returns: 所有的cell的attributes属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //当前屏幕可见范围
        let visibleRect : CGRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        
        /// 调用父类方法，拿到所有的attributes属性
        let oallAttributes = super.layoutAttributesForElements(in: rect)
        
        let centerX = collectionView!.contentOffset.x + 0.5 * collectionView!.bounds.width
        
        guard let allAttributes = oallAttributes else {
            return nil
        }
        
        for (_, attribute) in allAttributes.enumerated() {
            
            if visibleRect.intersects(attribute.frame) {   //如果当前item在屏幕上
                let itemCenterX = attribute.center.x;
                
                let maxDistance = 0.5 * (collectionView!.bounds.width + itemW)
                
                let scale = 1 + (1 - abs(itemCenterX - centerX) / maxDistance) * 0.5
                
                attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
                
            }
            
        }
        return allAttributes
    }
    
}
