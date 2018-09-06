//
//  LZCustomerArrearsVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLArrearsTableHeaderView;
@interface LZCustomerArrearsVC : BaseViewController

@end

@interface LLArrearsTableHeaderView:UIView
//总欠款个数
@property(nonatomic ,strong)UILabel * numberMoenyLable;
//元
@property(nonatomic ,strong)UILabel * messageLale;
@end
