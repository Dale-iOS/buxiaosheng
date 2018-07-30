//
//  BYAlertHelper.m
//  BangYou
//
//  Created by BangYou on 2017/9/28.
//  Copyright © 2017年 李麒. All rights reserved.
//
#import "BYAlertHelper.h"

@implementation BYAlertHelper
BYSingletonM(BYAlertHelper)

/// 添加多个view
- (BYAddSubViews)addSubviews {
    return ^(NSArray *subViews) {
        BYAlertViewItem *item = [BYAlertViewItem new];
        _alertItem = item;
        item.alertContentModel = BYAlertContentModeBottom;
        [item backView];
        item.subViews = subViews;
        
        return self;
    };
}

/// 添加一个view
- (BYAddSubView)addSubview {
    return ^(UIView *inView) {
        BYAlertViewItem *item = [BYAlertViewItem new];
        item.alertContentModel = BYAlertContentModeBottom;
        _alertItem = item;
        [item backView];
        if (inView) {
            item.subViews = @[inView];
        }
        return self;
    };
}


/// 默认-透明的灰暗颜色
- (BYAlertBackColor)backColor {
  
    return ^(UIColor *backColor) {
        self.alertItem.coverBtn.backgroundColor = backColor;
        self.alertItem.coverBtn.alpha = 0.5f;
        return self;
    };
}

/// 内部布局方
- (BYAlertsContentMode)contentModel {
    return ^(BYAlertContentMode contentModel) {
        self.alertItem.alertContentModel = contentModel;
        return self;
    };
}

#pragma mark - 显示&隐藏
/// 显示在什么地方
- (void(^)(void))showInWindow {
    return ^() {
      
        self.alertItem.supView = [UIApplication sharedApplication].keyWindow;
        [self showAnnimation];
    };
}
- (void(^)(UIView *supView))showInView {
    return ^(UIView *supView) {
      
        self.alertItem.supView = supView;
        [self showAnnimation];
    };
}


+ (void)hideAlert {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [BYAlertHelper sharedBYAlertHelper].alertItem.backView.alpha = 0.0f;
    }completion:^(BOOL finished) {
        
        BYAlertViewItem *alerItem = [BYAlertHelper sharedBYAlertHelper].alertItem;
        [alerItem.backView removeAllSubviews];
        [alerItem.backView removeFromSuperview];
        alerItem.backView = nil;
    }];

}


#pragma mark - private

- (void)showAnnimation {
    
    BYAlertViewItem *alerItem = self.alertItem;
    alerItem.backView.frame = alerItem.supView.bounds;
    [alerItem.supView addSubview:alerItem.backView];
    [alerItem.supView bringSubviewToFront:alerItem.backView];
    
    // 添加子控件
    CGFloat viewTop = 0;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0)];
    contentView.userInteractionEnabled = YES;
    for (int i = 0; i<alerItem.subViews.count; i++) {
        UIView *aView = alerItem.subViews[i];
        if ([aView isKindOfClass:[UIView class]]) {
            
            [contentView addSubview:aView];
            // 从上往下布局
            aView.origin = CGPointMake((contentView.width - aView.width)/2, viewTop);
            viewTop += aView.height;
        }else{
            NSLog(@"弹出框内部职能添加UIView的子类！");
        }
        
    }
    contentView.height = viewTop;
    [alerItem.backView addSubview:contentView];
    contentView.top = 0;
    switch (alerItem.alertContentModel) {

        case  BYAlertContentModeTop: contentView.top = 0; break;
        case  BYAlertContentModeLeft: contentView.top = alerItem.supView.height - viewTop; break;
        case  BYAlertContentModeBottom: contentView.top = alerItem.supView.height - viewTop; break;
        case  BYAlertContentModeRight: contentView.top = alerItem.supView.height - viewTop; break;
        case  BYAlertContentModeCenter: contentView.top = (alerItem.supView.height - viewTop)/2; break;
        default:
            break;
    }
    
   // 显示的过度动画
    for (UIView *View in alerItem.backView.subviews) {
        if (View != alerItem.backView.subviews.firstObject) {
            View.alpha = 0.0f;
            [View setAnnimationShow:YES annimationOption:KYAnnimationOptionsShowFromBotton duratime:0.25];
        }
        
    }
}

@end


@implementation BYAlertViewItem

- (UIView *)backView {
    
    if (!_backView) {
        //
        _backView = [[UIView alloc]init];
        UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.5f;
        [_backView addSubview:cover];
        [cover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(_backView);
        }];
        cover.adjustsImageWhenDisabled = NO;
        [cover addTarget:self action:@selector(clickCover) forControlEvents:UIControlEventTouchUpInside];
        self.coverBtn = cover;
    }
    return _backView;
}

- (void)clickCover {
    [BYAlertHelper  hideAlert];
}

@end
