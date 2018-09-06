//
//  BankDetailListViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankDetailListViewController : BaseViewController
@property (nonatomic ,strong) NSString *typeId;//单据来源id
//总收入的钱数
@property(nonatomic ,strong)UILabel * totalRevenueMoenyLable;
//总支出的钱数
@property(nonatomic ,strong)UILabel * totalSpendingMoenyLable;
@end
