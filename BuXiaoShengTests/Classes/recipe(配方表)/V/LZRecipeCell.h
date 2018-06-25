//
//  LZRecipeCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputCell.h"

@interface LZRecipeCell : UITableViewCell

///配方材料
@property(nonatomic,strong)TextInputCell *materialsCell;
///颜色
@property(nonatomic,strong)TextInputCell *colorCell;
///单位
@property(nonatomic,strong)TextInputCell *unitCell;
///材料用量
@property(nonatomic,strong)TextInputCell *amountCell;
///计算损耗
@property(nonatomic,strong)TextInputCell *wastageCell;
///计划用量
@property(nonatomic,strong)TextInputCell *planAmountCell;

@end
