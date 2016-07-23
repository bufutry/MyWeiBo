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
    var layout = NewFeatureLayout()
    
    
    init(){
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        //print(indexPath)
        let path = collectionView.indexPathsForVisibleItems().last!
        print(path)
        if path.item==pageIndex-1 {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell
            cell.enterBtn.hidden = false
            cell.starAnimation()
        }
    }
}


class NewFeatureCell: UICollectionViewCell {
    
    func setIndex(index:Int)  {
    enterBtn.hidden = true
        baImageView.image = UIImage.init(named: "new_feature_\(index+1)")
    }
    
    func starAnimation(){
        enterBtn.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
            self.enterBtn.transform = CGAffineTransformMakeScale(1, 1)
            }) { (_) in
                
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        baImageView.frame = contentView.frame
        enterBtn.center = contentView.center
        enterBtn.MaxY = contentView.height - 160
    
        contentView.addSubview(baImageView)
        contentView.addSubview(enterBtn)
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
        btn.setBackgroundImage(UIImage.init(named: "new_feature_button_highlighted"), forState: UIControlState.Normal)
         btn.setBackgroundImage(UIImage.init(named: "new_feature_button"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(NewFeatureCell.enterDetail), forControlEvents: .TouchUpInside)
     return btn
    
    }()
    
    func enterDetail()  {
        NSNotificationCenter.defaultCenter().postNotificationName(NeedReturnMainVC, object: nil)
    }
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
        collectionView?.bounces = false
    }
}