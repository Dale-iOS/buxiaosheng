//
//  LZDrawerChooseView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZDrawerChooseViewDelegate <NSObject>

@end

@interface LZDrawerChooseView : UIView
@property(nonatomic,weak)id<LZDrawerChooseViewDelegate>delegate;
@property(nonatomic,retain)UIView *alphaiView;
@property(nonatomic,retain)UIView *bgWhiteView;
@property(nonatomic,strong)UIButton *makeSureBtn;
@end
