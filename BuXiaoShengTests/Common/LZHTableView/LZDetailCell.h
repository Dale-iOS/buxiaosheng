//
//  LZDetailCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZDetailCell : UIView
///图标
@property(nonatomic,strong)UIImageView *leftIMV;
///标题
@property(nonatomic,strong)UILabel *titleLabel;

///标题右边的内容输入框
@property(nonatomic,strong)UITextField *contentTF;

///右边提示语
@property(nonatomic,strong)UILabel *hintLabel;

///右箭头
@property(nonatomic,strong)UIImageView *rightArrowImageVIew;

///顶部的线
@property(nonatomic,strong)UIView *topLine;
///底部的线
@property(nonatomic,strong)UIView *bottomLine;
@end
