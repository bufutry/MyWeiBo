//
//  NewFeatureViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/22.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit


let Identifier = "Identifier"

class NewFeatureViewController: UICollectionViewController {

    let pageIndex = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView?.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: Identifier)
    }
    
    //MARK: - UICollectionViewDelegate UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pageIndex
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Identifier, forIndexPath: indexPath) as! NewFeatureCell
        cell.setIndex(indexPath.item)
        return cell
        
    }
}


class NewFeatureCell: UICollectionViewCell {
    
    func setIndex(index:Int)  {
        baImageView.image = UIImage.init(named: "new_feature_(/index+1) ")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baImageView.frame = contentView.frame
    
        contentView.addSubview(baImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var baImageView:UIImageView = {
    
        let imageView = UIImageView()
        //imageView.frame =  cont
        return imageView
    }()
    
    private lazy var enterBtn:UIButton = {
      let btn = UIButton()
     btn.hidden = true
     return btn
    
    }()
}

class NewFeatureLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
            
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}