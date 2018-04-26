//
//  WarehouserTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarehouserTableViewCell : UITableViewCell

///标题
@property (nonatomic, strong) UILabel *titleLbl;

///颜色
@property (nonatomic, strong) UILabel *colorLbl;

///颜色
@property (nonatomic, strong) UILabel *weightLbl;

///出库或者入库状态
@property (nonatomic, strong) UILabel *stateLbl;

///时间
@property (nonatomic, strong) UILabel *timeLbl;

@end
