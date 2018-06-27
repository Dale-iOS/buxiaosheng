//
//  LZDepartmentManagerCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDepartmentManagerCell.h"
#import "LZDepartmentManagerModel.h"

@implementation LZDepartmentManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //头像
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.image = IMAGE(@"ordericon");
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(40);
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    //头像白色字
    self.iconNameLabel = [[UILabel alloc]init];
    self.iconNameLabel.font = FONT(12);
    self.iconNameLabel.textAlignment = NSTextAlignmentCenter;
    self.iconNameLabel.textColor = [UIColor whiteColor];
    [self.iconImageView addSubview:self.iconNameLabel];
    [self.iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(13);
        make.width.mas_offset(40);
        make.centerY.and.centerX.equalTo(self.iconImageView);
    }];
    
    //名
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = FONT(14);
    self.nameLabel.textColor = CD_Text33;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self.contentView).offset(0.5);
    }];
}

- (void)setModel:(LZDepartmentManagerModel *)model{
    _model = model;
    if (_model.name.length >3) {
        self.iconNameLabel.text = [_model.name substringToIndex:3];
    }else{
        self.iconNameLabel.text = _model.name;
    }
    self.nameLabel.text = _model.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
