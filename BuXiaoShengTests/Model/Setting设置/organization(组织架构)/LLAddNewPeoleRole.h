//
//  LLAddNewPeoleRole.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLAddNewPeoleRole : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * logo;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * parentId;
@property (nonatomic,strong) NSArray <LLAddNewPeoleRole*> * itemList;
@end
