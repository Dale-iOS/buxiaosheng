//
//  BYTimer.h
//  BangYou
//
//  Created by BangYou on 2017/12/14.
//  Copyright © 2017年 李麒. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BYSingleton.h"
@interface BYTimer : NSObject
BYSingletonH(BYTimer)
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSUInteger timeDex;

/// 时间回调
@property (copy,nonatomic)void (^timerRunBlock)(NSUInteger time);
/// 时间开始停止
- (void)timerPuase;
/// 时间开始
- (void)timerBegin;
/// 清理内存
- (void)clearTimer;

@end
