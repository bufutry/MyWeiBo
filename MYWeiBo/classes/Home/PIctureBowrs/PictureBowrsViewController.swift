//
//  PictureBowrsViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/8/3.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

let PictureBowrsReuseIdentifier = "PictureBowrsReuseIdentifier"


class PictureBowrsViewController: UIViewController {

    var index = 0
    var urls:[NSURL]?
    
    init(index:Int,urls:[NSURL]?){
        self.index = index
        self.urls = urls
       super.init(nibName:nil, bundle: nil)
    }
    
    private func setupUI(){
    view.addSubview(colletionView)
    view.addSubview(closeBtn)
    view.addSubview(saveBtn)
        
        closeBtn.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: view, size: CGSizeMake(90, 40), offset: CGPointMake(20, -20))
        saveBtn.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: view, size: CGSizeMake(90, 40), offset: CGPointMake(-20, -20))
        colletionView.xmg_Fill(view)
    
    }
    
    private lazy var closeBtn:UIButton = {
    
        let btn = UIButton()
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitle("关闭", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private lazy var saveBtn:UIButton = {
    
        let btn = UIButton()
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitle("保存", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private lazy var colletionView:UICollectionView = {
      let colle = UICollectionView.init(frame: UIScreen.mainScreen().bounds, collectionViewLayout: PictureBowrsLayout())
        colle.registerClass(PictureBowrsCell.self, forCellWithReuseIdentifier: PictureBowrsReuseIdentifier)
        colle.dataSource = self
        return colle
    }()
    
    func close()  {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save()  {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setupUI()

        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension PictureBowrsViewController:UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureBowrsReuseIdentifier, forIndexPath: indexPath) as! PictureBowrsCell
        cell.imageUrl = urls![indexPath.item]
        return cell
    }
}

class PictureBowrsLayout:UICollectionViewFlowLayout {
    override func prepareLayout() {
        
        super.prepareLayout()
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        
    }
}
