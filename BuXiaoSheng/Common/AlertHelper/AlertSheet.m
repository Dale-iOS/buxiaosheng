//
//  AlertSheet.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AlertSheet.h"
@interface AlertSheet ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation AlertSheet


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    _table = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorColor = LZHBackgroundColor;
    _table.separatorInset = UIEdgeInsetsZero;
    [self addSubview:_table];
}

- (void)reloadData {
    
    self.height = _dataSource.count * _rowHeight;
    _table.height = self.height;
    [self.table reloadData];
}

#pragma mark ---UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = FONT(15);
    cell.textLabel.textColor =  Text33;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !_didSelectAtRow?:_didSelectAtRow(indexPath.row,self.dataSource[indexPath.row]);
}

@end
