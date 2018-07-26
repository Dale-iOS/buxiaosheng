//
//  LZShipmentBigBoardView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  板布（开单）

#import "LZShipmentBigBoardView.h"
#import "BigGoodsAndBoardModel.h"
#import "LZGoodValueCell.h"
#import "BigGoodsFootView.h"

@interface LZShipmentBigBoardView ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *consumptionArr;


@end
@implementation LZShipmentBigBoardView

static NSString * const LZGoodValueCellID = @"LZGoodValueCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
    
}





#pragma mark - set & get
- (UITableView *)tableView
{
    if (_tableView == nil) {
        //        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight );
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        //        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - delegate
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
