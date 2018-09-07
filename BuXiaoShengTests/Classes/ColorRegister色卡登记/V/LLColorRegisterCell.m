//
//  LLColorRegisterCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLColorRegisterCell.h"
#import "TextInputCell.h"
@implementation LLColorRegisterCell

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
        self.itemView = [TextInputCell new];
        [self.contentView addSubview:self.itemView];
        [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
