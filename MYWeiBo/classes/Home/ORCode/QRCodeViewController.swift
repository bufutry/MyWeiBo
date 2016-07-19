//
//  QRCodeViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/19.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,UITabBarDelegate{


    @IBOutlet weak var scanViewHieghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var scanViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scanView: UIImageView!
    @IBOutlet weak var containViewHeigtConstraint: NSLayoutConstraint!
    @IBOutlet weak var coustomTabbar: UITabBar!
    
    //MARK: - private
    
    private func starAnimation(){
      self.scanViewTopConstraint.constant = -300
      UIView.animateWithDuration(3.0, animations: {
      UIView.setAnimationRepeatCount(MAXFLOAT)
      self.scanViewTopConstraint.constant = 0;
      self.scanViewHieghtConstraint.constant = self.containViewHeigtConstraint!.constant
      self.scanView.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupScan(){
        if !session.canAddInput(inputDevice) {
            return
        }
        if !session.canAddOutput(outputDevice) {
            return
        }
        session.addInput(inputDevice)
        session.addOutput(outputDevice)
        outputDevice.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeUPCECode]
        previewLayer.session = session
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        outputDevice.setMetadataObjectsDelegate(self, queue:dispatch_get_main_queue())
        session.startRunning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        setupScan()
        starAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coustomTabbar.selectedItem = coustomTabbar.items![0]
        coustomTabbar.delegate = self
        //starAnimation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    @IBAction func closeClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK:AVFoundoation Getter

    private lazy var session:AVCaptureSession = {
       let session = AVCaptureSession()
        return session
    }()
    
    private lazy var myDevic:AVCaptureDevice = {
      let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return device
    }()
    
    private lazy var inputDevice:AVCaptureDeviceInput? = {
        do{
            let  input = try AVCaptureDeviceInput.init(device: self.myDevic)
            return input
        }
        catch
        {
            print(error)
            return nil
        }
      
    }()
    
    private lazy var outputDevice:AVCaptureMetadataOutput = {
    let output = AVCaptureMetadataOutput.init()
        return output
    }()
    
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
     let previewLayer = AVCaptureVideoPreviewLayer.init()
        previewLayer.frame = UIScreen.mainScreen().bounds
      return previewLayer
    }()
    
    //MARK: - TabberDelegat
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.tag==1 {
            containViewHeigtConstraint.constant = 300
        }
        else
        {
           containViewHeigtConstraint.constant = 300 * 0.5
        }
        scanView.layer.removeAllAnimations()
        starAnimation()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
       // session.stopRunning()
       drawFramwork(metadataObjects)
        print(metadataObjects)
    }
    
    private func drawFramwork(metadataObject:[AnyObject]!){
        for ojec in metadataObject {
            if ojec is AVMetadataMachineReadableCodeObject {
                
                removeLayer()
                let code = previewLayer.transformedMetadataObjectForMetadataObject(ojec as!AVMetadataObject) as! AVMetadataMachineReadableCodeObject
               drawIng(code)
    
            }
        }
    }
    
    private func drawIng(codeObject:AVMetadataMachineReadableCodeObject){
        let subLayer = CAShapeLayer.init()
        subLayer.lineWidth = 4
        subLayer.fillColor = UIColor.clearColor().CGColor
        subLayer.strokeColor = UIColor.orangeColor().CGColor
        subLayer.frame = UIScreen.mainScreen().bounds
        
        let path = UIBezierPath.init()
        print(codeObject.corners)
        print(codeObject.corners!.first)
        let firstP = codeObject.corners!.first
        var point = CGPointZero
        var indenx = 0
        
        
        CGPointMakeWithDictionaryRepresentation((firstP as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        
        while indenx<codeObject.corners!.count-1 {
            indenx = indenx + 1
            CGPointMakeWithDictionaryRepresentation((codeObject.corners![indenx] as! CFDictionaryRef), &point)
            print(point)
            path.addLineToPoint(point)
        }
        path.closePath()
        subLayer.path = path.CGPath
        previewLayer.addSublayer(subLayer)
    }
  
    private func removeLayer(){
        for sub in previewLayer.sublayers! {
            if sub is CAShapeLayer {
                sub.removeFromSuperlayer()
            }
        }
    
    }
}
