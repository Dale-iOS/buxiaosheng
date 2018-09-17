//
//  LogEndCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"

@interface LogEndCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (strong, nonatomic) LZPurchasingInfoDetailModel *model;
@end
