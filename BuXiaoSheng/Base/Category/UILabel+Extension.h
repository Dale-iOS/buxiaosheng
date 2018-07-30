//
//  UILabel+Extension.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (UILabel *)labelWithColor:(UIColor *)textColor
                       font:(UIFont *)textFont;

- (void)setupAttributeString:(NSString *)text
                  changeText:(NSString *)changeText
                       color:(UIColor *)color;
@end
