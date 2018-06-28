//
//  LLMonthCalendarVc.h
//  iOS仿钉钉智能报表日历
//
//  Created by 周尊贤 on 2018/5/28.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLMonthCalendarVcDelegate <NSObject>

- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr;
- (void)didCancelBtnInCalendar;

@end

@interface LLMonthCalendarVc : UIViewController
@property(nonatomic,weak)id<LLMonthCalendarVcDelegate> delegate;
@end
