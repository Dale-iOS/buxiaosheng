//
//  ColorsCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimColorsCell.h"
#import "ReimColorDetailCell.h"
#import "ReimColorHeadCell.h"

@implementation ReimColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    // Initialization
}

- (void)showColorData:(NSMutableArray *)colorArray
{
    _colorArray = colorArray;
}

- (void)loadContactData
{
    self.tableViewContant.constant = 250+90;
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
    CGFloat rtn = 40.0;
    return rtn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        ReimColorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimColorHeadCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimColorHeadCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        ReimColorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimColorDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimColorDetailCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
