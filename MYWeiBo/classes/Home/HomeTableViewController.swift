//
//  HomeTableViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/11.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 }
