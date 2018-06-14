//
//  LZBankDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZBankDetailListModel;

@interface LZBankDetailModel : NSObject
@property(nonatomic,strong)NSArray<LZBankDetailListModel*> *itemList;
@property(nonatomic,copy)NSString *totalAmount;
@end

@interface LZBankDetailListModel : NSObject
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *bankId;
@property(nonatomic,copy)NSString *bankName;
@end
