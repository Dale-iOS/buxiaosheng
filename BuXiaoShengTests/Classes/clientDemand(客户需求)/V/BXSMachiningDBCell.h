//
//  BXSMachiningDBCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 加工-底色cell

#import "BaseTableCell.h"

#import "BXSDSModel.h"

@interface BXSMachiningDBCell : BaseTableCell

/// 删除底色
@property (copy,nonatomic)void (^clickDelectDBBlock)(void);
/// 选择名字
@property (copy,nonatomic)void (^clickNameCellBlock)(BXSDSModel *dsModel);
/// 选择颜色
@property (copy,nonatomic)void (^clickColorCellBlock)(void);
/// 添加仓库
@property (copy,nonatomic)void (^addCKClickBlock)(BXSDSModel *dsModel);
/// 删除一个库存
@property (copy,nonatomic)void (^clickDelectAKcBlock)(void);
/// 重新得到最底部的数据
@property (copy,nonatomic)void (^needGetBottomDataBlock)(void);


@property (strong,nonatomic)UILabel *addLabel;;
@property (strong,nonatomic)BXSDSModel *model;
@end
