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

- (void)setProductModel:(LZCollectionCheckDetailProductModel *)productModel
{
    _productModel = productModel;
    self.productNameLabel.text = productModel.productName;
    
    //假如细码值有小数，就只保留一位小数
    if ([productModel.totalNumber containsString:@"."]) {
        self.totalNumber.text = [NSString stringWithFormat:@"%.1f",productModel.totalNumber.doubleValue];
    }else{
        self.totalNumber.text = productModel.totalNumber;
    }
    [self loadContactData];
}

- (void)loadContactData
{
    CGFloat rowHeight = 0;
 
    
    for (LZInventoryListColorListModel *valListModel in _productModel.colorList) {
        
        if (valListModel.valList.count <= 5) {
            rowHeight += 40;
        }else
        {
            rowHeight += (valListModel.valList.count/5+1) * 40;
        }
        
    }
    self.tableViewContant.constant = 50*2 + rowHeight;
    [self.tableview reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rtn = _productModel.colorList.count + 1;
    return rtn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    CGFloat rowHeight = 0;
    if (_productModel.colorList.count > 0) {
        LZInventoryListColorListModel *valListModel = _productModel.colorList[indexPath.row-1];
        if (valListModel.valList.count <= 5) {
            rowHeight = 40;
        }else
        {
            rowHeight = (valListModel.valList.count/5+1) * 40;
        }
        
    }

    return rowHeight;
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
        
        if (_productModel.colorList.count > 0) {
         
            cell.colorListModel = _productModel.colorList[indexPath.row-1];
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
