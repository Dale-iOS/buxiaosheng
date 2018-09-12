//
//  LogisticsCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LogisticsCell.h"

@implementation LogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setLogisticslModel:(LZPurchasingInfoDetaiLogisticslModel *)logisticslModel
{
    _logisticslModel = logisticslModel;
    _timeLB.text = [NSString stringWithFormat:@"预计到货时间：%@",logisticslModel.arrivalTime];
    _numberLB.text = [NSString stringWithFormat:@"预计到货数量：%@",logisticslModel.number];
    _createTimeLB.text = logisticslModel.createTime;
    _remarkLB.text = @"附近的开发及圣诞快附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里乐房间的萨拉房间里快速登记付款了多少积分就付款了圣诞节付款了及圣诞快附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里乐房间的萨拉房间里快速登记付款了多少积分就付款了圣诞节付款了及圣诞快附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里附近的开发及圣诞快乐房间的萨拉房间里乐房间的萨拉房间里快速登记付款了多少积分就付款了圣诞节付款了";//logisticslModel.remark;
    
//    WMLineView *line = [[WMLineView alloc] initWithFrame:self.blueLine.frame withLineLength:5 withLineSpacing:3 withLineColor:[UIColor lightGrayColor]];
//    [self.contentView addSubview:line];
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
