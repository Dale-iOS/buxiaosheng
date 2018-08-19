
//  Created by 王猛 on 16/2/4.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "UIButton+WM.h"

@implementation UIButton (WM)

- (void)setImage:(UIImage *)image h_Image:(UIImage *)highImage{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:highImage forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image selected_Image:(UIImage *)selected_Image{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:selected_Image forState:UIControlStateSelected];
}

- (void)setBackgroundImage:(UIImage *)image selected_BackgroundImage:(UIImage *)selected_Image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:selected_Image forState:UIControlStateSelected];
}

- (void)setTitle:(NSString *)title font:(CGFloat)font titleColor:(UIColor *)color bgcolor:(UIColor *)bgcolor forState:(UIControlState)state target:(id)target action:(SEL)action controlEvents:(UIControlEvents)event;
{
    [self setTitle:title forState:state];
    [self setTitleColor:color forState:state];
    self.backgroundColor = bgcolor;
    self.titleLabel.font = [UIFont systemFontOfSize:font weight:1];
    [self addTarget:target action:action forControlEvents:event];

}

- (void)setButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor target:(id)target sel:(SEL)sel
{
    [self setTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.backgroundColor = bgColor;
    
    [self setBackgroundImage:[UIImage imageNamed:@"button_shy"] forState:UIControlStateNormal];
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];

}


- (void)setButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor imageName:(NSString *)imageName target:(id)target sel:(SEL)sel
{
    [self setTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:1];
    
    //[self setTitleColor:COLOR(115, 115, 115, 1) forState:UIControlStateNormal];
    
    self.backgroundColor = bgColor;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setButtonWithTitle:(NSString *)title font:(CGFloat)fontSize bgColor:(UIColor *)bgColor imageName:(NSString *)imageName target:(id)target sel:(SEL)sel
{
    [self setTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.backgroundColor = bgColor;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)setButtonWithTitle:(NSString *)title target:(id)target sel:(SEL)sel
{
    [self setTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self setBackgroundImage:[UIImage imageNamed:@"khzxwxz_ann"] selected_BackgroundImage:[UIImage imageNamed:@"khzxxz_ann"]];
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setButtonWithBgImage:(UIImage *)image target:(id)target sel:(SEL)sel
{
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}


/**  标题在上  */
- (void)titleOverTheImageTopWithSpace:(CGFloat)space
{
    [self judgeTheTitleInImageTop:YES space:space];
}

/**  标题在下  */
-(void)titleBelowTheImageWithSpace:(CGFloat)space
{
    [self judgeTheTitleInImageTop:NO space:space];
}

/**  判断标题是不是在上   */
- (void)judgeTheTitleInImageTop:(BOOL)isTop space:(float)space ;
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    float halfWidth = (titleSize.width + imageSize.width)/2;
    float halfHeight = (titleSize.height + imageSize.height)/2;
    
    float topInset = MIN(halfHeight, titleSize.height);
    float leftInset = (titleSize.width - imageSize.width)>0?(titleSize.width - imageSize.width)/2:0;
    float bottomInset = (titleSize.height - imageSize.height)>0?(titleSize.height - imageSize.height)/2:0;
    float rightInset = MIN(halfWidth, titleSize.width);
    
    if (isTop) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-titleSize.height-space, - halfWidth, imageSize.height+space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(topInset+space, leftInset, -bottomInset, -rightInset)];
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, - halfWidth, -titleSize.height-space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(-bottomInset, leftInset, topInset+space, -rightInset)];
    }
}

/**  图片在左  系统默认的样式  只需提供修改内边距的接口*/
-(void)imageOnTheTitleLeftWithSpace:(CGFloat)space{
    [self resetEdgeInsets];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, -space)];
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
}

/**  图片再右  */
- (void)imageOnTheTitleRightWithSpace:(CGFloat)space
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width+space, 0, -titleSize.width - space)];
}

//重置内边距
- (void)resetEdgeInsets
{
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
}

- (void)setButtonCorner:(CGFloat)corner
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = corner;
}

@end
