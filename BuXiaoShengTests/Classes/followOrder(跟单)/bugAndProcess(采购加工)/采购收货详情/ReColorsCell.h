//
//  ReimColorsCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchaseReceivingListDetailProductModel.h"

@interface ReColorsCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZPurchaseReceivingListDetailProductModel *productModel;
@property (nonatomic, strong) NSMutableArray *colorArray;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContant;

@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UILabel *houseNum;
@property (weak, nonatomic) IBOutlet UILabel *labelNum;
@property (weak, nonatomic) IBOutlet UILabel *refundAmount;
@property (weak, nonatomic) IBOutlet UILabel *settlementNum;
@property (weak, nonatomic) IBOutlet UILabel *yfLb;


- (void)loadContactData;

@end
