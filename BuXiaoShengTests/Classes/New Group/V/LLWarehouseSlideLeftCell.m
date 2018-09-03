//
//  LLWarehouseSlideLeftCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseSlideLeftCell.h"
@interface LLWarehouseSlideLeftCell()
@property(nonatomic ,strong)UILabel * titleLable;
@end
@implementation LLWarehouseSlideLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.titleLable = [UILabel new];
        [self.contentView addSubview:self.titleLable];
        self.titleLable.textColor = [UIColor darkGrayColor];
        self.titleLable.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

@end
