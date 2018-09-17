//
//  ReimColorsCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReColorsCell.h"
#import "ReColorDetailCell.h"
#import "ReColorHeadCell.h"

@implementation ReColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)setProductModel:(LZPurchaseReceivingListDetailProductModel *)productModel{
    _productModel = productModel;
    self.ProductName.text = productModel.productName;
    self.houseNum.text = productModel.houseNum;
    self.total.text = productModel.total;
    self.labelNum.text = productModel.houseNum;
    self.refundAmount.text = productModel.buyNum;
    self.settlementNum.text = productModel.settlementNum;
#warning 本单应付金额还没有计算
    for (int i = 0; i <productModel.colorList.count; i++) {
        LZPurchaseReceivingListDetailProductColorListModel *colorModel = productModel.colorList[i];
        //本单应收金额计算
        NSInteger shouldPrice = 0;
        for (int j = 0; j < colorModel.valList.count; j++) {
            LZPurchaseReceivingListDetailProductValListModel *vaListModel = colorModel.valList[j];
            shouldPrice += colorModel.price.integerValue * vaListModel.value.integerValue;
        }
        self.yfLb.text = [NSString stringWithFormat:@"%ld",shouldPrice];
    }
    
    [self loadContactData];
}


- (void)loadContactData
{
    CGFloat rowHeight = 0;
    
    for (LZPurchaseReceivingListDetailProductColorListModel *valListModel in _productModel.colorList) {
        
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
        LZPurchaseReceivingListDetailProductColorListModel *valListModel = _productModel.colorList[indexPath.row-1];
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
        ReColorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReColorHeadCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReColorHeadCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        ReColorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReColorDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReColorDetailCell" owner:self options:nil] lastObject];
            
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
