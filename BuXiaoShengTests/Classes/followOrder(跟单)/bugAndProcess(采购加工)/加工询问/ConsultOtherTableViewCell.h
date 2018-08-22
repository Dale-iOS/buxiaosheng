//
//  ConsultOtherTableViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchaseDetailModel.h"

@interface ConsultOtherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property (weak, nonatomic) IBOutlet UITextView *remarkTF;

@property (nonatomic, strong) LZPurchaseDetailModel *detailModel;

@end
