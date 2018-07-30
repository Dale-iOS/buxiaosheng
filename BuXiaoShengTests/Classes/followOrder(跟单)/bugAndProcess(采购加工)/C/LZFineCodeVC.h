//
//  LZFineCodeVC.h
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableVC.h"
#import "LZFindCodeModel.h"
@interface LZFineCodeVC : BaseTableVC


@property (copy,nonatomic)void (^changeCodeBlock) (LZFindCodeModel *model);

@property (copy,nonatomic)void (^addCodeBlock) (NSArray <LZFindCodeModel *>*array);


- (void)changeCodeWithModel:(LZFindCodeModel *)model;
- (void)changeCodeLeftTitle:(NSString *)title rightCode:(NSString *)code;


@end
