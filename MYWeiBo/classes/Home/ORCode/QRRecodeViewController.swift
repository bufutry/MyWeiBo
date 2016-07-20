//
//  QRRecodeViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/20.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class QRRecodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.frame = CGRectMake(0, 0, 300, 300)
        imageView.center = view.center
        imageView.backgroundColor = UIColor.redColor()
        imageView.image = creatImage()
        view.addSubview(imageView)
        view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func creatImage() -> UIImage?
    {
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue("我的名片".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        let image = filter?.outputImage
        
       return creatHeightImage(image!, siez:CGSizeMake(300, 300))
    }

    private func creatHeightImage(image:CIImage,siez:CGSize) ->UIImage{
       // 1.拿到缩放比例
        let extent = CGRectIntegral(image.extent)
        let scal = min(siez.width/extent.width, siez.height/extent.height)
    
     //创建bitcontext
        let witd = scal*extent.width
        let heigt = scal*extent.height
        let cs = CGColorSpaceCreateDeviceGray()!
        let bicontext = CGBitmapContextCreate(nil, Int(witd),Int(heigt), 8, 0, cs, 0)
        
    //创建BitImage
        let context = CIContext.init(options: nil)
        let bitImageRef = context.createCGImage(image, fromRect: extent)
        //设置图片背景质量
        CGContextSetInterpolationQuality(bicontext, .None)
        CGContextScaleCTM(bicontext, scal, scal)
        CGContextDrawImage(bicontext, extent, bitImageRef)
        
        let outImage = CGBitmapContextCreateImage(bicontext)
        
        return UIImage.init(CGImage: outImage!)
    
    }
    
    private lazy var imageView:UIImageView = UIImageView()
   

}
