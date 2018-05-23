//
//  FinancialCollectionViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHomeModel.h"

@interface FinancialCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titileLabel;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) LZHomeModel *model;
@end
