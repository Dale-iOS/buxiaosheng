//
//  LZChooseClientReceiptVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZChooseClientReceiptVC : UIViewController

@property(nonatomic,copy)void(^selectBlock)(NSString *type);

@end
