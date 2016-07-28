//
//  NormalStatusCell.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/28.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class NormalStatusCell: HomeTableViewCell {

    override func setupUI(){
        super.setupUI()
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contextView, size:CGSizeMake(10, 10),offset: CGPointMake(0, 10))
        pictureHeiCons = pictureView.xmg_Constraint(cons, attribute: .Height)
        pictureWitdCons = pictureView.xmg_Constraint(cons, attribute: .Width)
    }

}
