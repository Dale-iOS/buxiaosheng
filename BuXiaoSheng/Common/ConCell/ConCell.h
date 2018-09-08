//
//  ConCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTableCell.h"
typedef NS_ENUM(NSUInteger,ConType) {
    // 选择模式
    ConTypeA = 1,
    // 输入模式
    ConTypeB,
    // 展示
    ConTypeC,
};
@class ConItem;

@interface ConCell : BaseTableCell

@property (strong,nonatomic)ConItem *item;
@property (assign,nonatomic) CGFloat k_titlewWidth;
@property (copy,nonatomic)void (^endEdtingBlock)(ConItem *item);
@property (copy,nonatomic)void (^clickCellBlock)(void);
@end

@interface ConMarkCell : ConCell<UITextViewDelegate>

@end



@protocol ConItemDelegate <NSObject>
- (void)didClickItemInTextField:(UITextField *)tf;
@end

@interface ConItem : NSObject
@property (nonatomic, weak) id <ConItemDelegate> delegate;
// left
@property (strong,nonatomic)UIColor *titleColor;
// content
@property (strong,nonatomic)UIColor *textColor;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *kpText;
@property (copy,nonatomic)NSString *contenText;
@property (assign,nonatomic)ConType conType;
@property (nonatomic,assign)UIKeyboardType  keyboardType;
- (instancetype)initWithTitle:(NSString *)title
                       kpText:(NSString *)kpText
                      conType:(ConType)conType;

- (instancetype)initWithTitle:(NSString *)title
					   kpText:(NSString *)kpText
					  conType:(ConType)conType
			 withKeyboardType:(UIKeyboardType)pKeyboardType;

// 用于BXS
@property (copy,nonatomic)NSString *id;
@property (copy,nonatomic)NSString *name;
@property (assign,nonatomic)NSUInteger  status;
@end


