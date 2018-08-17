//
//  UIButton+KYTouch.h
//  TestCell
//
//  Created by Frank on 17/1/15.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "UIButton+EdgeInsets.h"

@implementation UIButton (EdgeInsets)
/*!
 * @style 方向
 * @space 文字距图片的距离
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    if (labelWidth == 0) {
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        labelWidth  = titleSize.width;
    }
    
    CGFloat imageInsetsTop = 0.0f;
    CGFloat imageInsetsLeft = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight = 0.0f;
    
    CGFloat titleInsetsTop = 0.0f;
    CGFloat titleInsetsLeft = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight = 0.0f;
    
    switch (style) {
        case ButtonEdgeInsetsStyleImageRight:
        {
            space = space * 0.5;
            
            imageInsetsLeft = labelWidth + space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = - (imageViewWidth + space);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case ButtonEdgeInsetsStyleImageLeft:
        {
            space = space * 0.5;
            
            imageInsetsLeft = -space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = space;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
        case ButtonEdgeInsetsStyleImageBottom:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5 - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
            
        }
            break;
        case ButtonEdgeInsetsStyleImageTop:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5 - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}




//  getter
- (UIEdgeInsets)expandHitEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, @selector(expandHitEdgeInsets));
    return value ? [value UIEdgeInsetsValue] : UIEdgeInsetsZero;
}

//  setter
- (void)setExpandHitEdgeInsets:(UIEdgeInsets)expandHitEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:expandHitEdgeInsets];
    objc_setAssociatedObject(self, @selector(expandHitEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//  该方法由hitTest:方法自动调用，决定由哪个视图相应用户的点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.expandHitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    UIEdgeInsets expandHitEdgeInsets = self.expandHitEdgeInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(CGRectGetMinX(bounds) - expandHitEdgeInsets.left,
                        CGRectGetMinY(bounds) - expandHitEdgeInsets.top,
                        CGRectGetWidth(bounds) + expandHitEdgeInsets.left + expandHitEdgeInsets.right,
                        CGRectGetHeight(bounds) + expandHitEdgeInsets.top + expandHitEdgeInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}
@end
