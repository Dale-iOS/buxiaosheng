//
//  LLWarehouseSlideLeftCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseSlideLeftCell.h"
#import "LLWarehouseSideModel.h"
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
-(void)setModel:(LLWarehouseSideModel *)model {
    _model = model;
    self.titleLable.text = model.colorName ? :model.houseName;
    if (model.seleted) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.titleLable = [UILabel new];
        [self.contentView addSubview:self.titleLable];
        self.titleLable.textColor = [UIColor blackColor];
        self.titleLable.font = [UIFont systemFontOfSize:16];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
