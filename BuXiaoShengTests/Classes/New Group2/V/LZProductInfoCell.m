//
//  LZProductInfoCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZProductInfoCell.h"

@implementation LZProductInfoCell
@synthesize iconImageView,titleLabel,subLabel,unitLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (UIImageView *)iconImageView{
    if (iconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel{
    if (titleLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentLeft;
//        label.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)subLabel{
    if (subLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.textAlignment = NSTextAlignmentLeft;
//        label.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:(subLabel = label)];
    }
    return subLabel;
}

- (UILabel *)unitLabel{
    if (unitLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.textAlignment = NSTextAlignmentLeft;
//        label.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:(unitLabel = label)];
    }
    return unitLabel;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(8);
        make.width.mas_offset(130);
        make.height.mas_offset(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.subLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
}

- (void)setModel:(LZProductInfoModel *)model{
    _model = model;
    
    [Utility showPicWithUrl:model.imgs imageView:self.iconImageView placeholder:IMAGE(@"noImage")];
    self.titleLabel.text = model.name;
    self.subLabel.text = model.alias;
    self.unitLabel.text = model.unitName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
