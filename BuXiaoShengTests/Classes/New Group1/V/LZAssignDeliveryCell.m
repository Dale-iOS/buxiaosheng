//
//  LZAssignDeliveryCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZAssignDeliveryCell.h"
#import "LZAssignDeliveryListModel.h"

@implementation LZAssignDeliveryCell

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
    
    //客户
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = FONT(14);
    self.nameLabel.textColor = CD_Text33;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    //标题
    self.subLabel = [[UILabel alloc]init];
    self.subLabel.font = FONT(12);
    self.subLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //需求量
    self.needLabel = [[UILabel alloc]init];
    self.needLabel.font = FONT(12);
    self.needLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.needLabel];
    [self.needLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(80);
        make.height.mas_offset(13);
    }];
    
    //出库数
    self.outLabel = [[UILabel alloc]init];
    self.outLabel.font = FONT(12);
    self.outLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.outLabel];
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subLabel.mas_bottom).offset(10);
        make.left.equalTo(self.needLabel.mas_right).offset(15);
        make.width.mas_offset(150);
        make.height.mas_offset(13);
    }];
    
    //时间
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = FONT(12);
    self.timeLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.needLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(120);
        make.height.mas_offset(13);
    }];
    
    //指派人
    self.assignLabel = [[UILabel alloc]init];
    self.assignLabel.font = FONT(12);
    self.assignLabel.textColor = [UIColor colorWithHexString:@"#25cce5"];
    self.assignLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.assignLabel];
    [self.assignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.needLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_offset(130);
        make.height.mas_offset(13);
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

- (void)setModel:(LZAssignDeliveryListModel *)model{
    _model = model;
    if (_model.drawerName.length >3) {
        self.iconNameLabel.text = [_model.drawerName substringFromIndex:3];
    }else{
        self.iconNameLabel.text = _model.drawerName;
    }
    self.nameLabel.text = [NSString stringWithFormat:@"客户：%@",_model.customerName];
    self.subLabel.text = _model.productName;
    self.needLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.needTotal];
    self.outLabel.text = [NSString stringWithFormat:@"出库数：%@",_model.number];
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    self.assignLabel.text = [NSString stringWithFormat:@"指派人：%@",_model.delivererName];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
