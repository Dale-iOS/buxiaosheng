//
//  ArrearsNameTextInputCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrearsNameTextInputCell : UIView

///标题
@property (nonatomic, weak) UILabel *titleLabel;

///前欠款
@property (nonatomic, weak) UILabel *beforeLabel;

///标题右边的内容输入框
@property (nonatomic, weak) UITextField *contentTF;

///画底部的线
@property (nonatomic, strong) UIView *lineView;

@end
