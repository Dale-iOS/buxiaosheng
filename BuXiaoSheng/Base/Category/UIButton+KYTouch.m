//
//  UIButton+KYTouch.m
//  TestCell
//
//  Created by Frank on 17/1/4.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "UIButton+KYTouch.h"
#import <objc/runtime.h>
@interface UIButton ()
/**
 *  bool 设置是否执行触及事件方法
 */
@property (nonatomic, assign) BOOL isExcuteEvent;
@end

@implementation UIButton (KYTouch)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL oldSel = @selector(sendAction:to:forEvent:);
        SEL newSel = @selector(newSendAction:to:forEvent:);
        // 获取到上面新建的oldsel方法
        Method oldMethod = class_getInstanceMethod(self, oldSel);
        // 获取到上面新建的newsel方法
        Method newMethod = class_getInstanceMethod(self, newSel);
        // IMP 指方法实现的指针,每个方法都有一个对应的IMP,调用方法的IMP指针避免方法调用出现死循环问题
        /**
         *  给oldSel添加方法
         *
         *  @param self      被添加方法的类
         *  @param oldSel    被添加方法的方法名
         *  @param newMethod 实现这个方法的函数
         *  (@types 定义该函数返回值类型和参数类型的字符串)
         *  @return 是否添加成功
         想了解的可以查看下:
         http://blog.csdn.net/lvmaker/article/details/32396167
         */
        BOOL isAdd = class_addMethod(self, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (isAdd) {
            // 将newSel替换成oldMethod
            class_replaceMethod(self, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        }else{
            // 给两个方法互换实现
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)newSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if (self.isExcuteEvent == 0) {
            self.timeInterVal = self.timeInterVal = 0? defaultInterval:self.timeInterVal;
        }
        if (self.isExcuteEvent) return;
        if (self.timeInterVal > 0) {
            self.isExcuteEvent = YES;
            [self performSelector:@selector(setIsExcuteEvent:) withObject:nil afterDelay:self.timeInterVal];
        }
    }
   [self newSendAction:action to:target forEvent:event];
}

- (NSTimeInterval)timeInterVal
{
    // 动态获取关联对象
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setTimeInterVal:(NSTimeInterval)timeInterVal
{
    // 动态设置关联对象
    objc_setAssociatedObject(self, @selector(timeInterVal), @(timeInterVal), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsExcuteEvent:(BOOL)isExcuteEvent
{
    // 动态设置关联对象
    objc_setAssociatedObject(self, @selector(isExcuteEvent), @(isExcuteEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isExcuteEvent
{
    // 动态获取关联对象
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

@end
