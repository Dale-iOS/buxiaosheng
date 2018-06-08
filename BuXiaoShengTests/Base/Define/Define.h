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

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

///原型宽比例
#define LZHScale_WIDTH(number) ([UIScreen mainScreen].bounds.size.width/750.0 * (number))
///原型高比例
#define LZHScale_HEIGHT(number) ([UIScreen mainScreen].bounds.size.height /1334.0 * (number))

#define LZHNavViewHeight (IPHONE_X ? 88.0:64.0)
#define LZHTabBarHeight (IPHONE_X ? 83.0:49.0)
//安全域高
#define IPHONEX_MARGIN_BOTTOM (IPHONE_X ? 34.0:0.0)

#define LLLoadPermissionsMessage @"该产品暂无权限"
#define LLLoadNoMoreMessage @"没有更多了"

#define LLLoadErrorMessage @"加载失败,请重试"

#define LLLoadingMessage   @"加载中..."

#define LLLoadNoNetWorking  @"暂无网络..."

#define LLLoadShoppingMessage  @"您的购物车空空如也"

#define LLLoginStateNotification @"LLLoginStateNotification"

#define LLAiliPayNotification @"LLAiliPayNotification"



/*  颜色
 CD For Color Define
 */

#define UIColorFromRGB(rgbValue)        UIColorFromRGBA(rgbValue,1.0)

#define UIColorFromRGBA(rgbValue,a)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define CD_Text                         UIColorFromRGB(0x000000)
#define Text33                       UIColorFromRGB(0x333333)
#define CD_Text33                       [UIColor colorWithHexString:@"#333333"]
//#define CD_Text66                       UIColorFromRGB(0x666666)

#define CD_Text66                       [UIColor colorWithHexString:@"#666666"]

//#define CD_Text99                       UIColorFromRGB(0x999999)
#define CD_Text99                       [UIColor colorWithHexString:@"#999999"]
#define CD_textCC                       [UIColor colorWithHexString:@"#cccccc"]

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define LZHBackgroundColor             [UIColor colorWithHexString:@"#e6e6ed"]

#define LZAppBlueColor            [UIColor colorWithHexString:@"#3d9bfa"]

//随机色
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//字体
#define FONT(x)   [UIFont systemFontOfSize:x]


//创建名为weakSelf的弱引用self对象
#define WEAKSELF typeof(self) __weak weakSelf = self;


#define UIAdaptiveRate(x) ((float) x)


#define IMAGE(imagename)                [UIImage imageNamed:imagename]

//网络请求的数据response转中文TF8
#define STRING(response)                [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]

//点击事件
#define addGestureRecognizer(viewName,clickName) do {                                                                          viewName.userInteractionEnabled = YES;\
[viewName addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickName)]];\
} while (0);


#define BXS_Alert(manager1) UIAlertController * alterVC = [UIAlertController alertControllerWithTitle:@"温馨提示: " message:manager1 preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleCancel handler:nil ];\
[alterVC addAction:cancle];\
[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alterVC animated:true completion:nil];

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//原型宽比例
#define LLScale_WIDTH(cgflot) (SCREEN_WIDTH/750.0*(cgflot))

#define LLAddHeight (IPHONE_X ? 24.0:0.0)

#define LLNavViewHeight (IPHONE_X ? 88.0:64.0)

#define LLTabBarHeight (IPHONE_X ? 83.0:49.0)

#define CONTENT_HEIGHT                  (APPHeight == 812.0 ? APPHeight-88-34:APPHeight-64)

//安全域高
#define IPHONEX_MARGIN_BOTTOM (IPHONE_X ? 34.0:0.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#endif /* Define_h */
