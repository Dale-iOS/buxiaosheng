//
//  LZBigGoodsHeadView.m
//  BuXiaoSheng
//
//  Created by ap on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBigGoodsHeadView.h"

@implementation LZBigGoodsHeadView
{
    
    __weak IBOutlet UIView *lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        lineView.backgroundColor =  LZHBackgroundColor;
    }
    return self;
}
@end
