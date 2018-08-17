//
//  BXSMachiningDBHeaderfooterView.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXSMachiningDBHeaderfooterView : UITableViewHeaderFooterView

/// 颜色
@property (strong,nonatomic)UILabel *colorlabel;
/// 需求量
@property (strong,nonatomic)UILabel *needLabel;

@property (strong,nonatomic)UIButton *addDBButton;
@end
