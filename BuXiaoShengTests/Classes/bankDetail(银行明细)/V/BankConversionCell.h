//
//  BankConversionCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankConversionCell : UIView

///选择转入的银行底图View
@property (nonatomic, strong) UIView *intoBankView;

///选择转入的银行名称
@property (nonatomic, strong) UILabel *intoBankLbl;

///银行转的图标
@property (nonatomic, strong) UIImageView *conversionImageView;
 
///选择转出的银行View
@property (nonatomic, strong) UIView *outBankView;

///选择转出的银行名称
@property (nonatomic, strong) UILabel *outBankLbl;

///选择转出的金额
@property (nonatomic, strong) UILabel *outPriceLbl;

@end



