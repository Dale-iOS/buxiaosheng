//
//  SetBranchCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputCell.h"

@protocol SetBranchCellDelegate <NSObject>

- (void)didClickAlterBtnInCell:(UITableViewCell *)cell;

@end

@interface SetBranchCell : UITableViewCell

@property (nonatomic, weak) id<SetBranchCellDelegate> delegate;

///类型
@property (nonatomic, strong) TextInputCell * typeItem;

///分店名称
@property (nonatomic, strong) TextInputCell * branchNameItem;

///是否结算分店
@property (nonatomic, strong) TextInputCell * settlementItem;

///是否接受任务
@property (nonatomic, strong) TextInputCell * assignmentItem;

///类型
@property (nonatomic, strong) TextInputCell * stateItem;

///分店n
@property (nonatomic, strong) UILabel * branchNumLbl;

@end
