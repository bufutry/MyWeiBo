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


class StatusePictureView: UICollectionView {
    
    var statuse:Statuses? {
        didSet{
          calculationSize()
          reloadData()
        }
    }
    
    
    var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(){
     super.init(frame: CGRectZero, collectionViewLayout: layout)
        setupUI()
     dataSource = self
    }
    
    private func setupUI(){
        backgroundColor = UIColor.whiteColor()
       registerClass(StatusePictureCell.self, forCellWithReuseIdentifier: PictureReuseIdentifier)
    }
    
    
    func calculationSize() -> CGSize {
        
        
        let with:CGFloat = 90
        let margin:CGFloat = 10
        if statuse?.storePic?.count==0 || statuse?.storePic==nil {
            return CGSizeZero
        }
        
        if(statuse?.storePic?.count == 1){
            let url = statuse?.storePic?.first
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url?.absoluteString)
            print(statuse?.user?.name)
            print(image.size)
            layout.itemSize = image.size
            return image.size
        }

        if statuse?.storePic?.count==4 {
            return CGSizeMake(with*2+margin, with*2+margin)
        }
        else
        {
            let mod = CGFloat(statuse!.storePic!.count/3)
            return  CGSizeMake(with*3+margin*2,with+(with+margin)*mod)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StatusePictureView:UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statuse?.storePic?.count ?? 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureReuseIdentifier, forIndexPath: indexPath) as! StatusePictureCell
        let url = statuse?.storePic![indexPath.row]
        cell.bgImageView.sd_setImageWithURL(url)
        return cell
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