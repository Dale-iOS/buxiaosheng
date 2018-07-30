//
//  LineView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LineView.h"
@implementation LineView

+ (instancetype)lineViewOfHeight:(CGFloat)height {
    
    LineView *lineView = [LineView new];
    
    lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    lineView.backgroundColor = LZHBackgroundColor;
    return lineView;
    
}
@end
