//
//  LZChooseBankTypeModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZChooseBankTypeModel : NSObject
@property(nonatomic,assign)BOOL isSelect;//用于判断是否被选中
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@end
