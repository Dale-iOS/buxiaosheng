//
//  UILabel+Extension.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithColor:(UIColor *)textColor
                       font:(UIFont *)textFont {
    
    UILabel *label = [UILabel new];
    label.textColor = textColor;
    label.font = textFont;
    
    return label;
}
- (void)setupAttributeString:(NSString *)text
                  changeText:(NSString *)changeText
                       color:(UIColor *)color {
    

    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    @try {
        NSRange range = [text rangeOfString:changeText];
        /// 越界问题
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    } @catch (NSException *exception) {
        NSLog(@" 设置富文本 出问题 %@",exception.description);
    } @finally {
        self.attributedText = str;
    }
    
}
@end
