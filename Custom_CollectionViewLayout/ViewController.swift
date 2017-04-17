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
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 100, y: 100, width: self.view.bounds.width, height: 200), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kReuseIdentifier)
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseIdentifier, for: indexPath)
        return cell
    }
}

