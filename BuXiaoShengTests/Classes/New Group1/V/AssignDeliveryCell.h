//
//  AssignDeliveryCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZAssignDeliveryModel;
@interface AssignDeliveryCell : UITableViewCell
@property(nonatomic,strong)UIImageView *selectIM;//选择图标
@property(nonatomic,strong)UIView *whithBgView;//背景白色底图
@property(nonatomic,strong)UIImageView *iconIM;//头像底图
@property(nonatomic,strong)UILabel *iconName;//头像图标文字
@property(nonatomic,strong)UILabel *titleLbl;//标题
@property(nonatomic,strong)UILabel *subLbl;//副标题
@property(nonatomic,strong)UILabel *demandLbl;//需求量，出库数
@property(nonatomic,strong)UILabel *timeLbl;//日期
@property(nonatomic,strong)LZAssignDeliveryModel *model;

@end
