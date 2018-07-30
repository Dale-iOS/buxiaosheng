//
//  BXSAllCodeCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 采购收货的总码的cell

#import <UIKit/UIKit.h>
#import "BXSAllCodeModel.h"
@class ConItem;
@interface BXSAllCodeCell : BaseTableCell<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)BXSAllCodeModel *item;

- (void)setName:(NSString *)name unit:(NSString *)unit;


@property (copy,nonatomic)void (^clickBottomBlock)(void);
@property (copy,nonatomic)void (^clickUnitBlock)(ConItem *item);
@property (copy,nonatomic)void (^endEdtingBlock)(void);
//修改入库--细码的时候
@property (copy,nonatomic)void (^clickChangeRkBlock)(void);
@property (copy,nonatomic)void (^clickAddCodelBlock)(BXSAllCodeModel *item);
@property (copy,nonatomic)void (^clickChangeCodeBlock)(LZFindCodeModel *model);

@end
