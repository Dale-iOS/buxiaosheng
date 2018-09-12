//
//  LogStartCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"
#import "WMLineView.h"

@interface LogStartCell : UITableViewCell

@property (nonatomic, strong) LZPurchasingInfoDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
