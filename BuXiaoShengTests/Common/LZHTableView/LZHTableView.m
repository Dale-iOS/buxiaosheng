//
//  LZHTableView.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZHTableView.h"

@implementation LZHTableView
@synthesize dataSoure,tableHeaderView,tableFooterView,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delaysContentTouches = NO;
        
        [self addSubview:_tableView];
    }
    return self;
}

//设置能否移动
- (void)setIsScrollEnable:(BOOL)isScrollEnabled
{
    _tableView.scrollEnabled = isScrollEnabled;
    
    return;
}

//设置尺寸
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _tableView.frame = self.bounds;
}

///设置tableview headerView
- (void)setTableViewHeaderView:(UIView *)view
{
    tableHeaderView = view;
    _tableView.tableHeaderView = view;
}

///设置tableview footerView
- (void)setTableViewFooterView:(UIView *)view
{
    tableFooterView = view;
    _tableView.tableFooterView = view;
}

///刷新tableview DataSource
- (void)setDataSoure:(NSMutableArray *)dataSoureArray
{
    dataSoure = dataSoureArray;
    [_tableView reloadData];
}

- (void)reloadData
{
    [_tableView reloadData];
}

#pragma mark ---------- uitablview delegate datasorce
///返回行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSoure.count;
}

///返回组数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LZHTableViewItem *item = [self.dataSoure objectAtIndex:section];
    if ([item isKindOfClass:[LZHTableViewItem class]])
    {
        return item.sectionRows.count;
    }
    return 0;
}

///头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    LZHTableViewItem *item = [self.dataSoure objectAtIndex:section];
    if ([item isKindOfClass:[LZHTableViewItem class]])
    {
        CGFloat height = CGRectGetHeight(item.sectionView.frame);
        if (height == 0)
        {
            height = item.sectionView.intrinsicContentSize.height;
        }
        return height;
    }
    return 0;
}

///设置headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LZHTableViewItem *item = [self.dataSoure objectAtIndex:section];
    
    if ([item isKindOfClass:[LZHTableViewItem class]])
    {
        return item.sectionView;
    }
    return nil;
}

///设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZHTableViewItem *item = [self.dataSoure objectAtIndex:indexPath.section];
    if ([item isKindOfClass:[LZHTableViewItem class]])
    {
        UIView *cell = [item.sectionRows objectAtIndex:indexPath.row];
        CGFloat height = CGRectGetHeight(cell.frame);
        
        if (height == 0) {
            height = cell.intrinsicContentSize.height;
        }
        return height;
    }
    return 0;
}

///设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZHTableViewItem *item = [self.dataSoure objectAtIndex:indexPath.section];
    UIView *view = [item.sectionRows objectAtIndex:indexPath.row];
    
    NSString *identifier = [NSString stringWithFormat:@"indexpath %ld %ld %ld",(long)indexPath.section,(long)indexPath.row,view.hash];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.contentView.backgroundColor = item.backgroundColor;
        [cell.contentView addSubview:view];
        
        if (!item.canSelected)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

///点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (delegate && [delegate respondsToSelector:@selector(LzhTableView:didSelectRowAtIndexPath:)])
    {
        [delegate LzhTableView:self didSelectRowAtIndexPath:indexPath];
    }
    
    
}

@end

