//
//  LZFindCodeModel.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZFindCodeModel : NSObject


@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSString *code;
@property (strong,nonatomic)NSString *id;

+ (id)initModelTitle:(NSString *)title code:(NSString *)code;
@end
