//
//  CellView.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ConCell.h"

@interface CellView : UIView

@property (copy,nonatomic)void (^clickCellBlock)(void);

@property (strong,nonatomic,readonly)ConItem *item;

@property (strong,nonatomic)UITextField *midTF;


@property (assign,nonatomic) CGFloat k_titlewWidth;


- (instancetype)initWithFrame:(CGRect)frame
                         item:(ConItem *)item;

- (void)setContentWithItem:(ConItem*)item;

@end
