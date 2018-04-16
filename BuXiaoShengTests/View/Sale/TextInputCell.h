//
//  TextInputCell.h
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputCell : UIView

///标题
@property (nonatomic, weak) UILabel *titleLabel;

///标题右边的内容输入框
@property (nonatomic, weak) UITextField *contentTF;

///右边提示语
@property (nonatomic, weak) UILabel *hintLabel;

///右箭头
@property (nonatomic, strong) UIImageView *rightArrowImageVIew;

///画底部的线
@property (nonatomic, strong) UIView *lineView;

@end
