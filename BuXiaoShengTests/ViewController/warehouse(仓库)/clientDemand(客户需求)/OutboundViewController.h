//
//  OutboundViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LZOutboundModel.h"

@interface OutboundViewController : BaseViewController
@property(nonatomic,copy)NSString *id;

@property (nonatomic,strong) NSArray <LLOutboundRightModel*>  * rightSeleteds;

@property (nonatomic,strong) LZOutboundItemListModel  * sectionModel;
@end
