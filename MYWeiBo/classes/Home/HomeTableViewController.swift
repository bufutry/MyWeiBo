//
//  HomeTableViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/11.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit



class HomeTableViewController: BaseTableViewController {

    var since_id:Int = 0
    var max_id:Int  = 0
    var isPull = true
    
    var list:[Statuses]?{
        didSet{
           tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin {
          visitorView?.setupInfo(true, messgae: "关注一些人，回这里看看有什么惊喜", imgeName: "visitordiscover_feed_image_house")
        }
        else
        {
           setupNav()
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changePresent), name: PresentationControlleWillHidden, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changePresent), name: PresentationControlleWillShow, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "picture:", name: StatusePictureViewDidSelect, object: nil)
            
          //  modalTransitionStyle =
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .None
            tableView.registerClass(NormalStatusCell.self, forCellReuseIdentifier: HomeTableViewCellIdentifier.normalr.rawValue)
             tableView.registerClass(RetweetedViewCell.self, forCellReuseIdentifier:  HomeTableViewCellIdentifier.retweeted.rawValue)
            

            refreshControl = RefreshControl()
            
            refreshControl?.addTarget(self, action: #selector(loadData), forControlEvents: .ValueChanged)
            tableView.addSubview(mindeView)
            list = [Statuses]()
            loadData()
        }
        
    }
    
    func picture(not:NSNotification) {
       let indx = not.object![StatusePictureViewIndex] as! Int
        let imageArray = not.object![StatusePictureViewImageUrl] as! [NSURL]
        print(#function)
        print(imageArray[indx])
        let vc = PictureBowrsViewController.init(index: indx, urls: imageArray)
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @objc private func loadData(){
        if isPull {
            since_id = list?.first?.id ?? 0
            max_id = 0
        }
        else
        {
            since_id = 0
            max_id = ((list?.last?.id)! - 1) ?? 0
        }
        Statuses.loadSatuses(since_id, max_id: max_id) {(netdata, error) in
             self.refreshControl?.endRefreshing()
        if error==nil{
            
            if self.isPull == true
            {
                 self.mindeViewAnimation()
                 if netdata?.count==0
                 {
                    self.mindeView.text = "暂无更新"
                 }else
                 {
                   self.mindeView.text = "更新了"+"\(netdata!.count)"+"条微博"
                 }
            }
            
            if netdata == nil || netdata?.count==0
            {
               self.isPull = true
               return
            }
             self.list = netdata
            if self.isPull
            {
             self.list =  netdata! + self.list!
            }
            else
            {
             self.list = self.list! + netdata!
            }
            self.isPull = true
        }
      }
    }
    
    deinit{
      NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @objc private func changePresent(){
        print(#function)
        let  titleBtn:TitleButton = navigationItem.titleView! as!TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    private func mindeViewAnimation(){
        UIView.animateWithDuration(1, animations: { 
            self.mindeView.y = self.mindeView.height + 20
            }) { (_) in
            UIView.animateWithDuration(0.3, animations: { 
                self.mindeView.y = -self.mindeView.height*2
            })
        }
    }
    
    private lazy var popAnima:PopcoverAnimation = {
       let popAnima = PopcoverAnimation()
        return popAnima
    }()
    
    private lazy var mindeView:UILabel = {
       let lab = UILabel()
        lab.backgroundColor = UIColor.orangeColor()
        lab.textColor = UIColor.whiteColor()
        lab.textAlignment = .Center
        lab.font = UIFont.systemFontOfSize(14)
        lab.frame = CGRectMake(0, -80, UIScreen.mainScreen().bounds.width, 44)
        return lab
    }()

    private func setupNav()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.customItem(self, action: #selector(leftBarButtonClick), imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem.customItem(self, action: #selector(rightBarButtonClick), imageName: "navigationbar_pop")
        let titleBtn = TitleButton()
        titleBtn.setTitle("我的 ", forState: .Normal)
        titleBtn.addTarget(self, action: #selector(titleButtonClick), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    //MARK: - NavEvent
    func leftBarButtonClick(){
        print(#function)
    }
    
    func rightBarButtonClick(){
        print(#function)
        let  sb = UIStoryboard.init(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    func titleButtonClick(btn:TitleButton){
        print(#function)
        let sb = UIStoryboard.init(name: "PopCoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
         vc!.transitioningDelegate = popAnima
        vc!.modalPresentationStyle = .Custom
        presentViewController(vc!, animated: true) {
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 }

extension HomeTableViewController
{
    // MARK: - Table view data source
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mode = list![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier( HomeTableViewCellIdentifier.cellIdentifier(mode), forIndexPath: indexPath) as! HomeTableViewCell
        cell.statuses = mode
        if indexPath.row == (list?.count)!-1 {
            isPull = false
            loadData()
        }
        return cell
        
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mode = list![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeTableViewCellIdentifier.cellIdentifier(mode)) as! HomeTableViewCell
        var height:CGFloat = 0
        
        if mode.cellHeight==0 {
            height = cell.cellHight(mode)
        }
        else
        {
           height = mode.cellHeight
        }
       
        return height
    }
   
}

