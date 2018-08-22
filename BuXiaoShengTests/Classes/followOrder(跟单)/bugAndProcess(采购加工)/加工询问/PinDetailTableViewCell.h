//
//  PinDetailTableViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchaseDetailModel.h"

@interface PinDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiaoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;

@property (nonatomic, copy) LZPurchaseBottomListModel *bottomModel;

@end
