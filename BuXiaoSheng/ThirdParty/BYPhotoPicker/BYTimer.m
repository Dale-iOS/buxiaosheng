//
//  BYTimer.m
//  BangYou
//
//  Created by BangYou on 2017/12/14.
//  Copyright © 2017年 李麒. All rights reserved.
//

#import "BYTimer.h"
  
@implementation BYTimer
BYSingletonM(BYTimer)

-(NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runing) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];//开始循环
        //启动定时器
        _timer.fireDate = [NSDate distantPast];
    }
    return _timer;
}

/// 时间停止
- (void)timerPuase {
    self.timer.fireDate = [NSDate distantFuture];
}
/// 时间开始
- (void)timerBegin {
    self.timeDex = 0;
    self.timer.fireDate = [NSDate date];
}
- (void)runing {
    self.timeDex ++;
    if (_timerRunBlock) {
        _timerRunBlock(self.timeDex);
    }
}
/// 清理内存
- (void)clearTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _timeDex = 0;
    }
}
@end
