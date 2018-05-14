//
//  LZPickerView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef void (^TouchButton)(UIBarButtonItem *barButton);
typedef void (^OnCompletionBlock)(id item);
typedef NSString* (^TitleBlock)(id item);

@interface LZPickerView :  UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *_picker;
    TouchButton _leftActionBlock;
    TouchButton _rightActionBlock;
    OnCompletionBlock _onCompletionBlock;
    TitleBlock _titleBlock;
    
    NSInteger _currentIndex;
}
@property (strong, nonatomic) NSArray *items;

-(void)setLeftActionBlock:(TouchButton)actionBlock;
-(void)setRightActionBlock:(TouchButton)actionBlock;
-(void)setOnCompletionBlock:(OnCompletionBlock)onCompletionBlock;
-(void)setTitleBlock:(TitleBlock)titleBlock;

@end

