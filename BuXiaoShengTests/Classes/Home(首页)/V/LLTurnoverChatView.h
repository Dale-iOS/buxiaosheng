//
//  LLTurnoverChatView.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLTurnoverListModel;
@interface LLTurnoverChatView : UIView
@property(nonatomic ,copy)NSArray< LLTurnoverListModel*> * chartData;
@end
