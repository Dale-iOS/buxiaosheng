//
//  LZChooseBankTypeCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZChooseBankTypeModel.h"

@interface LZChooseBankTypeCell : UICollectionViewCell

@property(nonatomic,strong)LZChooseBankTypeModel *model;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)NSString *id;
@end
