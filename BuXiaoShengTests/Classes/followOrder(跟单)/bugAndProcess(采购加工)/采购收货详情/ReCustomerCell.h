//
//  CustomerCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//
/*

 
 "orderDetailId": 185,
 "total": 9999,
 "createTime": 20180629110124,


 */
#import <UIKit/UIKit.h>
#import "LZPurchaseReceivingListDetailModel.h"
@interface ReCustomerCell : UITableViewCell


@property (nonatomic, strong) LZPurchaseReceivingListDetailModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;
@property (weak, nonatomic) IBOutlet UILabel *arrearsPriceLB;

@property (weak, nonatomic) IBOutlet UILabel *realpayPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *copewithPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLB;

@property (weak, nonatomic) IBOutlet UILabel *houseNameLB;
@property (weak, nonatomic) IBOutlet UILabel *remarkLB;

@property (weak, nonatomic) IBOutlet UILabel *factoryNoLB;

@property (weak, nonatomic) IBOutlet UILabel *factoryNameLB;

@property (weak, nonatomic) IBOutlet UILabel *contactNameLB;
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLB;

@end
