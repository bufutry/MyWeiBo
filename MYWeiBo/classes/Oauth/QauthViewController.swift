//
//  QauthViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/21.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class QauthViewController: UIViewController,UIWebViewDelegate {
    
    let appKey = "2905852712"
    let appSecret = "250b90a6af207099f4cfa8aeeda1533d"
    let appRedirectUrl = "http://www.baidu.com"
    
    
    override func loadView() {
        super.loadView()
        view = wbViwe
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        let url = NSURL.init(string: "https://api.weibo.com/oauth2/authorize?"+"client_id="+appKey+"&redirect_uri="+appRedirectUrl)
        let requst = NSURLRequest.init(URL: url!)
        
        wbViwe.loadRequest(requst)
        
        setupNav()
    }
    
    func setupNav() {
        navigationItem.title = "登陆"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style:.Plain, target: self, action: #selector(QauthViewController.close))
    }
    
    func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    private lazy var wbViwe:UIWebView = {
      let web = UIWebView()
        web.frame = UIScreen.mainScreen().bounds
        web.delegate = self
        return web
    
    }()
    
    //MARK: - Delegat
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request)
        let url = request.URL!.absoluteString
        if url.hasPrefix("https://api.weibo.com") {
            return true
        }
        let code = "code="
        var codeStr:String?
        
        if ((request.URL?.query?.hasSuffix(code)) != nil){
          codeStr = request.URL?.query?.substringFromIndex(code.endIndex)
            getAcessToken(codeStr!)
        }
        
        return false
    }
    
    private func getAcessToken(code:String){
       
    }
}
