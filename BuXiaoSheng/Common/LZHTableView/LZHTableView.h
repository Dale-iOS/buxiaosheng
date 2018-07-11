//
//  LZHTableView.h
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LZHTableViewItem.h"

@class LZHTableView;

@protocol LZHTableViewDelegate <NSObject>

@optional
- (void)LzhTableView:(nonnull LZHTableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
@end

@interface LZHTableView : UIView <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

///dataSource:LZHTableViewItem array
@property (nonatomic, strong) NSMutableArray *dataSoure;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, assign) id<LZHTableViewDelegate> delegate;

- (void)reloadData;

///设置能不能滑动
- (void)setIsScrollEnable:(BOOL)isScrollEnabled;

@end
