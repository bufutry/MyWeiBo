//
//  HomeTableViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/11.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

let HomereuseIdentifier = "HomereuseIdentifier"


class HomeTableViewController: BaseTableViewController {

    
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
          //  modalTransitionStyle =
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .None
            tableView.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: HomereuseIdentifier)
            loadData()
        }
        
    }
    
    private func loadData(){
    
      Statuses.loadSatuses { (netdata, error) in
        if error==nil{
          self.list = netdata
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
    
    private lazy var popAnima:PopcoverAnimation = {
       let popAnima = PopcoverAnimation()
        return popAnima
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
        let cell = tableView.dequeueReusableCellWithIdentifier(HomereuseIdentifier, forIndexPath: indexPath) as! HomeTableViewCell
        
        let mode = list![indexPath.row]
        cell.statuses = mode
        return cell
        
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mode = list![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(HomereuseIdentifier, forIndexPath: indexPath) as! HomeTableViewCell
        
        var height:CGFloat = 300
        
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

