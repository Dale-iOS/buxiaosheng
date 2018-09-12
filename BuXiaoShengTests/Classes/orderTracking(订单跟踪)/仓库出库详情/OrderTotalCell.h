//
//  OrderTotalCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZOutOrderProductModel.h"

@interface OrderTotalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *totalTiaoLB;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
