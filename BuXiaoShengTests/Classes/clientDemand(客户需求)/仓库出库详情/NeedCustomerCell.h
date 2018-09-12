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
#import "LZCustomerNeedsDetailModel.h"
@interface NeedCustomerCell : UITableViewCell


@property (nonatomic, strong) LZCustomerNeedsDetailModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLB;

@end
