//
//  BaseTableCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
    }
    return self;
}

- (void)setup{};

@end
