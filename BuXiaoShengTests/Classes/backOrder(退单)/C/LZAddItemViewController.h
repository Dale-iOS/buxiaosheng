//
//  LZAddItemViewController.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

@interface LZAddItemViewController : BaseViewController

@property (nonatomic,strong) void(^selectItems)(NSArray *items);

//是否修改细码
@property (nonatomic,assign,getter=isModifyItem) BOOL modifyItem;
@property (nonatomic,strong) NSString *itemDetail;

@end
