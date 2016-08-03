//
//  PictureBowrsCell.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/8/3.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import SDWebImage

class PictureBowrsCell: UICollectionViewCell {
    
    var imageUrl:NSURL?{
        didSet{
         imageView.sd_setImageWithURL(imageUrl) { (image, re, _, _) in
            if image != nil {
                self.resetUI()
                self.setPostion(image)
            }
         }
        }
    }
    
    private func setSize(image:UIImage){
      let scal = image.size.height / image.size.width
      let size = UIScreen.mainScreen().bounds.size
      imageView.frame = CGRectMake(0, 0, size.width, size.width*scal)
    }
    
    private func setPostion(image:UIImage){
      setSize(image)
        let size = UIScreen.mainScreen().bounds.size
        if imageView.height>size.height {
           scollView.contentSize = CGSizeMake(size.width, imageView.height)
        }
        else
        {
           let y = (size.height - imageView.height) * 0.5
           scollView.contentInset = UIEdgeInsetsMake(y, 0, y, 0)
        }
    }
    
    private func resetUI(){
      scollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
      imageView.transform = CGAffineTransformIdentity
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
     contentView.addSubview(scollView)
     scollView.addSubview(imageView)
     scollView.frame  = UIScreen.mainScreen().bounds
    }
    
    private lazy var scollView:UIScrollView = {
        let scollView = UIScrollView()
        scollView.maximumZoomScale = 2.0
        scollView.minimumZoomScale = 0.5
        scollView.delegate = self
        return scollView
    }()
    
    lazy var imageView:UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PictureBowrsCell:UIScrollViewDelegate{
  
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let size = UIScreen.mainScreen().bounds.size
        
        let y = imageView.y<0 ? 0 : (size.height - imageView.height) * 0.5
        let x = imageView.x<0 ? 0 : (size.width - imageView.width) * 0.5
        
        scollView.contentInset = UIEdgeInsetsMake(y, x, y, x)
    }
    
}