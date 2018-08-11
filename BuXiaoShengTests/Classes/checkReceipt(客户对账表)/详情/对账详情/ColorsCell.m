//
//  ColorsCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ColorsCell.h"
#import "ColorDetailCell.h"
#import "ColorHeadCell.h"

@implementation ColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    // Initialization
}

- (void)showColorData:(NSMutableArray *)colorArray
{
    
}
- (void)loadContactData
{
    self.tableViewContant.constant = 50 + 100*4;
    [self.tableview reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rtn = 5;
    return rtn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    CGFloat rtn = 30*3;
    return rtn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        ColorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorHeadCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ColorHeadCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        ColorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ColorDetailCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
