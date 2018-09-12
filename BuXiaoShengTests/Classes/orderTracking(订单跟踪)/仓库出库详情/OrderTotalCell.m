//
//  OrderTotalCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "OrderTotalCell.h"

@implementation OrderTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    double number = 0;
    NSInteger total = 0;
    for (LZOutOrderProductModel *productModel in dataArray) {
        
        number += [productModel.number doubleValue];
        total += [productModel.total integerValue];
        
    }
    
    self.totalTiaoLB.text = [NSString stringWithFormat:@"总条数：%ld",(long)total];
    self.totalNumberLB.text = [NSString stringWithFormat:@"总数量：%.1f",number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
