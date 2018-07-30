//
//  AlertSheet.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertSheet : UIView

@property (assign,nonatomic) CGFloat rowHeight;

@property (strong,nonatomic)NSArray *dataSource;

@property (copy,nonatomic)void (^didSelectAtRow)(NSInteger row,NSString *title);


@property (strong,nonatomic,readonly)UITableView *table;

-(instancetype)initWithFrame:(CGRect)frame;

- (void)reloadData;

@end
