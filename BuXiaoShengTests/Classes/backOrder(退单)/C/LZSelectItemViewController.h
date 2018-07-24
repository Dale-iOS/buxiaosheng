//
//  LZSelectItemViewController.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    LZSelectItemVCSelectProduct    = 1,
    LZSelectItemVCSelectColor      = 2,
    LZSelectItemVCSelectWarehouse = 3,
    LZSelectItemVCSelectPayMentWay = 4
} LZSelectItemVCSelectType;

@interface LZSelectItemViewController : BaseViewController

@property (nonatomic,strong) void(^selectItemBlock)(NSString *itemStr);
@property (nonatomic,assign) LZSelectItemVCSelectType type;

@end
