//
//  LineView.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMLineView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) NSInteger lineSpace;
@property (nonatomic, assign) NSInteger lineLength;
@property (nonatomic, assign) NSInteger height;

- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor;

@end
