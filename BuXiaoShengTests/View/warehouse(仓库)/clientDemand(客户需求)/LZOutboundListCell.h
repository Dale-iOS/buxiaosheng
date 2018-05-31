//
//  LZOutboundListCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZOutboundListCellDelegate<NSObject>
- (void)didClickInWarehouseNumTF:(UITextField*)warehouseNumTF;
@end

@interface LZOutboundListCell : UITableViewCell
@property(nonatomic,weak)id<LZOutboundListCellDelegate> delegate;
@property(nonatomic,strong)UITextField *warehouseNumTF;
@property(nonatomic,strong)UITextField *OutNumTF;
@property(nonatomic,strong)UITextField *lineNumTF;
@property(nonatomic,strong)UITextField *fromWarahouseTF;
@end
