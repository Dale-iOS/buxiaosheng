//
//  UIButton+Category.m
//  JDemo
//
//  Created by BangYou on 2018/1/18.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

-(void)setExpandHitEdgeInsets:(UIEdgeInsets)expandHitEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:expandHitEdgeInsets];
    objc_setAssociatedObject(self, @selector(expandHitEdgeInsets), value, OBJC_ASSOCIATION_RETAIN);
}

-(UIEdgeInsets)expandHitEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, @selector(expandHitEdgeInsets));
    return value?[value UIEdgeInsetsValue]:UIEdgeInsetsZero;
}

// 重写父类方法
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
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}


/// 构造一个上面图片下面文字的按钮（使用sd_）
+ (instancetype)initWithBottomLabelHeight:(CGFloat)height {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeCenter;
    button.imageView.sd_layout
    .topEqualToView(button)
    .rightEqualToView(button)
    .leftEqualToView(button)
    .bottomEqualToView(button.titleLabel);
    
   
    button.titleLabel.sd_layout
    .topSpaceToView(button.imageView, 0)
    .leftEqualToView(button).rightEqualToView(button)
    .bottomEqualToView(button)
    .heightIs(height);
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    return button;
}


///使用sd_布局依赖sdlayout
- (void)setupSDLayoutWithInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {

    UIImage *contentImage = self.imageView.image;
    CGFloat imageEdge = 4.0f;
    switch (style) {
        case ButtonEdgeInsetsStyleImageLeft:
        {
            self.imageView.sd_layout
            .topEqualToView(self)
            .leftEqualToView(self).offset(imageEdge)
            .bottomEqualToView(self)
            .widthIs(contentImage.size.width);
            
            self.titleLabel.sd_layout
            .bottomEqualToView(self)
            .leftSpaceToView(self.imageView, space)
            .rightEqualToView(self)
            .topEqualToView(self);
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            
        }break;
        case ButtonEdgeInsetsStyleImageRight:
        {
            self.titleLabel.sd_layout
            .bottomEqualToView(self)
            .centerXEqualToView(self).offset(-(contentImage.size.width + space)/2)
            .topEqualToView(self);
            [self.titleLabel setSingleLineAutoResizeWithMaxWidth:self.width-contentImage.size.width -space];
            
            self.imageView.sd_layout
            .topEqualToView(self)
            .leftSpaceToView(self.titleLabel, space)
            .bottomEqualToView(self)
            .widthIs(contentImage.size.width);
            

        }break;
        case ButtonEdgeInsetsStyleImageTop:
        {
            CGFloat titleH = self.titleLabel.font.pointSize;
            CGFloat imgH = contentImage.size.height;
            CGFloat topSpace = (self.height - (titleH + imgH + space))/2;
            
            self.imageView.sd_layout
            .topSpaceToView(self, topSpace)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(imgH);
           
            
            self.titleLabel.sd_layout
            .topSpaceToView(self.imageView, space)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(titleH);
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }break;
        case ButtonEdgeInsetsStyleImageBottom:
        {
            self.imageView.sd_layout
            .bottomEqualToView(self)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(contentImage.size.height);
            
            self.titleLabel.sd_layout
            .bottomSpaceToView(self.imageView, space)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topEqualToView(self);
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }break;
            
        default:
            break;
    }
    self.imageView.contentMode = UIViewContentModeCenter;
}
@end
