//
//  LLAuditMangerSectionModel.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLAuditMangerSectionView;
typedef void(^AuditMangerSectionViewBlcok)(LLAuditMangerSectionView * sectionView);
@class LLAuditMangerModel;
#import <UIKit/UIKit.h>

@interface LLAuditMangerSectionView : UITableViewHeaderFooterView
@property (nonatomic,strong) LLAuditMangerModel * model;
@property (nonatomic,assign) NSInteger  section;
@property (nonatomic,copy) AuditMangerSectionViewBlcok  block;
@end
