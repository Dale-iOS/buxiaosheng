//
//  SubCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBackOrderDetialModel.h"

@interface ReimSubCell : UITableViewCell
@property (strong, nonatomic) LZBackOrderDetialModel *model;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *totalLine;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@end
