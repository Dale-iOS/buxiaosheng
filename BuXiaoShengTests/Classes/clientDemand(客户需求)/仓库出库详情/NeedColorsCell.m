//
//  ReimColorsCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "NeedColorsCell.h"
#import "NeedColorDetailCell.h"
#import "NeedColorHeadCell.h"

@implementation NeedColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)setProductModel:(LZCustomerNeedsDetailProductModel *)productModel{
    _productModel = productModel;
    self.ProductName.text = productModel.productName;
    self.houseNum.text = productModel.total;

    [self loadContactData];
}


- (void)loadContactData
{
    CGFloat rowHeight = 0;
    
    for (LZCustomerNeedsDetailProductColorListModel *valListModel in _productModel.colorList) {
        
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
 
    return 1+_productModel.colorList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 40;
    }
    CGFloat rowHeight = 40;
    if (_productModel.colorList.count > 0) {
        LZCustomerNeedsDetailProductColorListModel *valListModel = _productModel.colorList[indexPath.row-1];
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
        NeedColorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeedColorHeadCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NeedColorHeadCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        NeedColorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeedColorDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NeedColorDetailCell" owner:self options:nil] lastObject];
            
        }
        if (_productModel.colorList.count >0) {
            cell.colorListModel = _productModel.colorList[indexPath.row -1];
            
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
