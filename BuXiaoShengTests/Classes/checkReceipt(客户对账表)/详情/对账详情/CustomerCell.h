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
#import "LZCollectionCheckDetailMsgModel.h"
@interface CustomerCell : UITableViewCell

@property (nonatomic, strong) LZCollectionCheckDetailMsgModel *msgModel;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLB;
@property (weak, nonatomic) IBOutlet UILabel *customerMobileLB;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;
@property (weak, nonatomic) IBOutlet UILabel *receivablePriceLB;
@property (weak, nonatomic) IBOutlet UILabel *depositPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *arrearsLB;
@property (weak, nonatomic) IBOutlet UILabel *remarkLB;

@property (weak, nonatomic) IBOutlet UILabel *trimPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *netreceiptsPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *settleNumber;
@property (weak, nonatomic) IBOutlet UILabel *outNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *totalLB;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *settlementLabel;

@end
