//
//  LLBackOrdeContentModel.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLBackOrdeContentModel : NSObject
@property (nonatomic,copy) NSString * leftTitle;

@property (nonatomic,copy) NSString * placeholder;
//default为隐藏
@property (nonatomic,assign) BOOL rightArrowHidden;

@property (nonatomic,copy) NSString * content;
@end
