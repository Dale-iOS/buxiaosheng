//
//  Define.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#ifndef Define_h
#define Define_h

//app宽 高
#define APPHeight                   [UIScreen mainScreen].bounds.size.height
#define APPWidth                    [UIScreen mainScreen].bounds.size.width

/*  iOS版本
 */
#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS7Dot0                        ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define IOS9                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#define IOS11                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)

/*  屏幕尺寸
 */
#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONEX                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4_WIDTH                   320.000000
#define IPHONE5_WIDTH                   320.000000
#define IPHONE6_WIDTH                   375.000000
#define IPHONE6PLUS_WIDTH               414.000000
#define IPHONEX_Height                  812.000000

///原型宽比例
#define LZHScale_WIDTH(number) ([UIScreen mainScreen].bounds.size.width/750.0 * (number))
///原型高比例
#define LZHScale_HEIGHT(number) ([UIScreen mainScreen].bounds.size.height /1334.0 * (number))

#define LZHNavViewHeight (IPHONE_X ? 88.0:64.0)
#define LZHTabBarHeight (IPHONE_X ? 83.0:49.0)
//安全域高
#define IPHONEX_MARGIN_BOTTOM (IPHONE_X ? 34.0:0.0)



/*  颜色
 CD For Color Define
 */
#define CD_Text                         UIColorFromRGB(0x000000)
//#define CD_Text33                       UIColorFromRGB(0x333333)
#define CD_Text33                       [UIColor colorWithHexString:@"#333333"]
#define CD_Text66                       UIColorFromRGB(0x666666)
//#define CD_Text99                       UIColorFromRGB(0x999999)
#define CD_Text99                       [UIColor colorWithHexString:@"#999999"]
#define CD_textCC                       [UIColor colorWithHexString:@"#cccccc"]

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define LZHBackgroundColor             [UIColor colorWithHexString:@"#eeeeee"]

//随机色
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f]

//字体
#define FONT(x)   [UIFont systemFontOfSize:x]


//创建名为weakSelf的弱引用self对象
#define WEAKSELF typeof(self) __weak weakSelf = self;


#define UIAdaptiveRate(x) ((float) x)


#define IMAGE(imagename)                [UIImage imageNamed:imagename]


#endif /* Define_h */
