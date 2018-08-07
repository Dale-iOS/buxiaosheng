//
//  LZBankListModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZBankListListModel;

@interface LZBankListModel : NSObject
@property (nonatomic, strong) NSArray <LZBankListListModel*> *itemList;
@property(nonatomic, copy) NSString *totalExpenditure;
@property(nonatomic, copy) NSString *totalIncome;
@end

@interface LZBankListListModel : NSObject
@property(nonatomic, copy) NSString *amount;
@property(nonatomic, copy) NSString *bankName;
@property(nonatomic, copy) NSString *createTime;
@property(nonatomic, copy) NSString *incomeType;
@property(nonatomic, copy) NSString *objectName;
@property(nonatomic, copy) NSString *type;
@end
