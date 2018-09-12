//
//  LogistiscCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"
#import "WMLineView.h"
@interface LogistiscCell : UITableViewCell


@property (nonatomic, strong) LZPurchasingInfoDetaiLogisticslModel *logisticslModel;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
