//
//  XiMaCollectionViewCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimXiMaCollectionViewCell.h"

@implementation ReimXiMaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setValListModel:(LZBackOrderDetialProductValListModel *)valListModel{
    _valListModel = valListModel;
    self.value.text = valListModel.value;
}

@end
