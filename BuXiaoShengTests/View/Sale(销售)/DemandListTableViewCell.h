//
//  DemandListTableViewCell.h
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandListTableViewCell : UITableViewCell

///品名
@property (nonatomic, weak) UITextField *nameTF;

///颜色
@property (nonatomic, weak) UITextField *colorTF;

///条数
@property (nonatomic, weak) UITextField *lineNumTF;

///数量
@property (nonatomic, weak) UITextField *numTF;

///单价
@property (nonatomic, weak) UITextField *priceTF;

@end
