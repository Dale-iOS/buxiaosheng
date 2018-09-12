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
#import "LZOutOrderCustomerModel.h"
@interface OrderCustomerCell : UITableViewCell

@property (nonatomic, strong) LZOutOrderCustomerModel *customerModel;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLB;
@property (weak, nonatomic) IBOutlet UILabel *customerMobileLB;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;
@property (weak, nonatomic) IBOutlet UILabel *receivablePriceLB;

@property (weak, nonatomic) IBOutlet UILabel *remarkLB;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLB;

@end
