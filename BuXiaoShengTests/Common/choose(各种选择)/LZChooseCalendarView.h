//
//  LZChooseCalendarView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZChooseCalendarViewDelegate <NSObject>

@end

@interface LZChooseCalendarView : UIView

@property(nonatomic,weak)id<LZChooseCalendarViewDelegate>delegate;


@end
