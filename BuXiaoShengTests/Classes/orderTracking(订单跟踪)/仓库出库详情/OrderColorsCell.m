//
//  ColorsCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "OrderColorsCell.h"
#import "OrderColorDetailCell.h"
#import "OrderColorHeadCell.h"

@implementation OrderColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    // Initialization
}

- (void)setProductModel:(LZOutOrderProductModel *)productModel
{
    _productModel = productModel;
    self.productNameLabel.text = productModel.productName;
    self.totalNumber.text = productModel.number;
    self.tiaoNumberLabel.text = [NSString stringWithFormat:@"(条数：%@)",productModel.total];
    [self loadContactData];
}

- (void)loadContactData
{
    CGFloat rowHeight = 0;
 
    
    for (LZOutOrderProductColorListModel *valListModel in _productModel.colorList) {
        
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
        LZOutOrderProductColorListModel *valListModel = _productModel.colorList[indexPath.row-1];
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
        OrderColorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderColorHeadCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderColorHeadCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        OrderColorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderColorDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderColorDetailCell" owner:self options:nil] lastObject];
            
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
