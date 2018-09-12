//
//  LogisticsCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"
#import "WMLineView.h"
@interface LogisticsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@property (weak, nonatomic) IBOutlet UILabel *remarkLB;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLB;

@property (weak, nonatomic) IBOutlet UIView *startRound;


@property (weak, nonatomic) IBOutlet UIView *blueLine;

@property (nonatomic, strong) LZPurchasingInfoDetaiLogisticslModel *logisticslModel;

@end
