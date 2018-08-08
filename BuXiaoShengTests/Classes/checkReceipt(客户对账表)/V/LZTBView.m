//
//  LZTBView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTBView.h"
#import "LZTypeMsgCell.h"
#import "LZTypeProductCell.h"
#import "LZTypeProductModel.h"

@interface LZTBView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *originSource;
@end

@implementation LZTBView

- (void)setUIOriginSource:(NSMutableArray *)origin {
    self.originSource = origin;
    [self.tbView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubTbView];
    }
    return self;
}
- (void)setSubTbView {
    self.originSource = [NSMutableArray arrayWithCapacity:0];
    self.tbView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self addSubview:self.tbView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.originSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LZTypeMsgCell *cell = [LZTypeMsgCell resuLZTypeMsgCell:tableView];
        
        return cell;
    }else {
        LZTypeProductCell *cell = [LZTypeProductCell refuProductCell:tableView];
        
        LZTypeProductModel *model = self.originSource[indexPath.section - 1];
        
        
        [cell changeCellHeight:model];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 350;
    }
    LZTypeProductModel *model = self.originSource[indexPath.section - 1];
    return model.totalHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:221/255.0 green:225/255.0 blue:233/255.0 alpha:1.0];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

@end
