//
//  LZOutboundSectionView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZOutboundModel.h"
@class LZOutboundSectionView;
@protocol LZOutboundSectionViewDelegate<NSObject>

@optional

-(void)sectionViewDelegate:(LZOutboundSectionView *)sectionView;

@end
@interface LZOutboundSectionView : UITableViewHeaderFooterView
@property (nonatomic,assign) NSInteger  section;
@property (nonatomic,weak) id<LZOutboundSectionViewDelegate>  delegate;
@property (nonatomic,strong) UIButton * foldingBtn;
@property(nonatomic,strong)LZOutboundItemListModel *model;
@end
