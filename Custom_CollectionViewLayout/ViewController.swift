//
//  ViewController.swift
//  Custom_CollectionViewLayout
//
//  Created by 王志盼 on 2017/4/17.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

private let kReuseIdentifier = "UICollectionViewCell"

class ViewController: UIViewController {

    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 180), collectionViewLayout: ZYLineLayout(itemW: 100, itemH: 100))
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kReuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - 设置UI
extension ViewController {
    
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
    
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}

