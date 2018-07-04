//
//  TextInputTextView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputTextView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
///画底部的线
@property (nonatomic, strong) UIView *lineView;
@end
