//
//  LZAuditDetailInfoView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZAuditDetailModel.h"

@interface LZAuditDetailInfoView : UIView
///时间
@property (nonatomic, strong) TextInputCell *timeLabel;
///开销类型
@property (nonatomic, strong) TextInputCell *typeLabel;
///金额
@property (nonatomic, strong) TextInputCell *moneyLabel;
///审批人
@property (nonatomic, strong) TextInputCell *approverLabel;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTestView;
@property (nonatomic, strong) LZAuditDetailModel *model;
@end
