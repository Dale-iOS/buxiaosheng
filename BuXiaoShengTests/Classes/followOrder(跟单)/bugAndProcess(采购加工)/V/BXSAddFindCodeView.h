//
//  BXSAddFindCodeView.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZFindCodeModel.h"
@protocol BXSAddFindCodeViewDelegate <NSObject>

@optional;

- (void)didClickAddCode;
- (void)didClickChangeCode:(LZFindCodeModel *)model;
@end

@interface BXSAddFindCodeView : UIView

@property (strong,nonatomic)NSMutableArray *codeArray;

@property (weak,nonatomic) id <BXSAddFindCodeViewDelegate>delegate;
@end




