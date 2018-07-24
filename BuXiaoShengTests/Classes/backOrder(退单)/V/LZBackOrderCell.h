//
//  LZBackOrderCell.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BtnClickType) {
    BtnClickTypeFold       = 0,
    BtnClickTypeAddYard    = 1,//新增一条
    BtnClickTypeAddItem    = 2//添加细码
};

@class LZBackOrderItem, LZBackOrderGroup, LZBackOrderCell;

@protocol LZBackOrderCellDelegate<NSObject>

@optional
//btn点击事件
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell btnClickType:(BtnClickType)type forIndexPath:(NSIndexPath *)indexPath;
//选择品名,颜色等事件
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell selectItemForIndexPath:(NSIndexPath *)indexPath;

//刷新
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell reloadForIndexPath:(NSIndexPath *)indexPath;

//修改细码
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell modifyItemForIndexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end

@interface LZBackOrderCell : UITableViewCell

+ (__kindof UITableViewCell *)cellWithTableView:(UITableView *)tableView cellType:(NSInteger)cellType;
@property (weak, nonatomic) id<LZBackOrderCellDelegate> delegate;
@property (nonatomic,strong) LZBackOrderItem *item;
@property (nonatomic,strong) LZBackOrderGroup *group;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
