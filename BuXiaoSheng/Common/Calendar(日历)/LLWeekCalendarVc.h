//
//  LLWeekCalendarVc.h
//  iOS仿钉钉智能报表日历
//
//  Created by 周尊贤 on 2018/5/28.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLWeekCalendarVcDelegate <NSObject>

- (void)didaffirmBtnInWeekCalendarWithSelectArray:(NSMutableArray *)weekArray;
- (void)didCancelBtnInCalendar;

@end

@interface LLWeekCalendarVc : UIViewController
@property(nonatomic,weak)id<LLWeekCalendarVcDelegate> delegate;
@end
