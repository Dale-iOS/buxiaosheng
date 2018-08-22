//
//  PinNameTableViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchaseDetailModel.h"

@interface PinNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pinNameLabel;
@property (nonatomic, strong) LZPurchaseDetailModel *detailModel;
@end
