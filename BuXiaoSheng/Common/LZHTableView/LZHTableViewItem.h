//
//  LZHTableViewItem.h
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LZHTableViewItem : NSObject

@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) NSArray *sectionRows; // UIView array
@property (nonatomic, assign) BOOL canSelected;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
