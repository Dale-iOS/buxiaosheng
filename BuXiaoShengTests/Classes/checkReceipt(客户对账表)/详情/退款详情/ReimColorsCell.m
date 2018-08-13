//
//  ReimColorsCell.m
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
}

- (void)setProductModel:(LZBackOrderDetialProductModel *)productModel{
    _productModel = productModel;
    self.ProductName.text = productModel.productName;
    self.houseNum.text = productModel.houseNum;
    self.total.text = productModel.total;
    self.labelNum.text = productModel.labelNum;
    self.refundAmount.text = productModel.refundAmount;
    self.settlementNum.text = productModel.settlementNum;
    
    [self loadContactData];
}


- (void)loadContactData
{
    CGFloat rowHeight = 0;
    
    for (LZBackOrderDetialProductColorListModel *valListModel in _productModel.colorList) {
        
        if (valListModel.valList.count <= 5) {
            rowHeight += 40;
        }else
        {
            rowHeight += (valListModel.valList.count/5+1) * 40;
        }
        
    }
    self.tableViewContant.constant = 50*2 + rowHeight + 90;
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
        LZBackOrderDetialProductColorListModel *valListModel = _productModel.colorList[indexPath.row-1];
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
        if (_productModel.colorList.count >0) {
//            我不知道要减几，一直报错
            cell.colorListModel = _productModel.colorList[indexPath.row -1];
            NSLog(@"123");
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
