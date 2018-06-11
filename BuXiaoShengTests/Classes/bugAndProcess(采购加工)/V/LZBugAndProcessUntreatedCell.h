//
//  LZBugAndProcessUntreatedCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBugAndProcessUntreatedCell : UITableViewCell
///白色底图
@property (nonatomic, strong)UIView *bgView;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;
///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;
///标题
@property (nonatomic, strong) UILabel *titleLabel;
///内容 副标题
@property (nonatomic, strong) UILabel *subLabel;
///需求量
@property (nonatomic, strong) UILabel *demandLabel;
///线
@property(nonatomic,strong)UIView *lineView;
///时间
@property (nonatomic, strong) UILabel *timeLabel;
///采购收货
@property(nonatomic,strong)UIButton *receiptBtn;
///采购询问
@property(nonatomic,strong)UIButton *askBtn;
///完成
@property(nonatomic,strong)UIButton *completeBtn;
@end
