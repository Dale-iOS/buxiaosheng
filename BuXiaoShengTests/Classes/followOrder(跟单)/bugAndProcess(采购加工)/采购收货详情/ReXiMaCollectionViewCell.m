//
//  XiMaCollectionViewCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReXiMaCollectionViewCell.h"

@implementation ReXiMaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setValListModel:(LZPurchaseReceivingListDetailProductValListModel *)valListModel
{
    _valListModel = valListModel;
    _colorValue.text = valListModel.value;
    if (_colorValue.text.length >=4) {
        _colorValue.font = FONT(12);
    }
}

@end
