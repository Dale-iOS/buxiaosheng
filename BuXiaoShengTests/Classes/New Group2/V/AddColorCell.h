//
//  AddColorCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLColorRegistModel;
@interface AddColorCell : UITableViewCell

///颜色
@property (nonatomic, strong) UILabel *titleLbl;

///颜色内容
@property (nonatomic, strong) UITextField *contentTF;

@property(nonatomic ,strong)LLColorRegistModel * model;
@property(nonatomic ,strong)NSIndexPath * indexPath;

/**
 设置cell信息
 
 @param title cell左侧标题
 @param desc  占位文字信息
 @param type 键盘类型  0、表示正常键盘 1、表示数字键盘
 @param text 填充文字
 @param textFieldBlock 输入内容回调
 */
//-(void)setCellInfo:(NSString*)title withInputDesc:(NSString*)desc withKeybordType:(NSInteger )type withText:(NSString *)text WithReturnBlock:(void (^)(NSString *result))textFieldBlock;

-(void)setCellTitle:(NSString*)title WithReturnBlock:(void (^)(NSString *result))textFieldBlock;

@end
