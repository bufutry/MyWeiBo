//
//  StatusePictureView.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/27.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import SDWebImage

let  PictureReuseIdentifier = "PictureReuseIdentifier"
let  StatusePictureViewDidSelect = "StatusePictureViewDidSelect"
let  StatusePictureViewIndex = "StatusePictureViewIndex"
let  StatusePictureViewImageUrl = "StatusePictureViewImageUrl"


class StatusePictureView: UICollectionView {
    
    var index:Int = 0
    var lagerIamegArray:[NSURL]?
    
    
    var imageArray:[NSURL]? {
        didSet{
         // calculationSize()
          reloadData()
        }
    }
    
    
    var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(){
     super.init(frame: CGRectZero, collectionViewLayout: layout)
        setupUI()
     dataSource = self
     delegate = self
    }
    
    private func setupUI(){
        backgroundColor = UIColor.whiteColor()
       registerClass(StatusePictureCell.self, forCellWithReuseIdentifier: PictureReuseIdentifier)
    }
    
    
    func calculationSize() -> CGSize {
        
        
        let with:CGFloat = 90
        let margin:CGFloat = 10
        layout.itemSize = CGSizeMake(width, width)
        if imageArray?.count==0 || imageArray==nil {
            return CGSizeZero
        }
        
        if(imageArray!.count == 1){
            let url = imageArray!.first
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url?.absoluteString)
            layout.itemSize = image.size
            return image.size
        }

        if imageArray?.count==4 {
            return CGSizeMake(with*2+margin, with*2+margin)
        }
        else
        {
            let mod = CGFloat(imageArray!.count/3)
            return  CGSizeMake(with*3+margin*2,with+(with+margin)*mod)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StatusePictureView:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray?.count ?? 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureReuseIdentifier, forIndexPath: indexPath) as! StatusePictureCell
        let url = imageArray![indexPath.row]
        cell.bgImageView.sd_setImageWithURL(url)
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let info:[String:AnyObject] = [StatusePictureViewIndex:indexPath.item,StatusePictureViewImageUrl:imageArray!]
        
        NSNotificationCenter.defaultCenter().postNotificationName(StatusePictureViewDidSelect, object: info)
        
    }
}

class StatusePictureCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
      contentView.addSubview(bgImageView)
        bgImageView.xmg_Fill(contentView)
    }
    
    lazy var bgImageView:UIImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}