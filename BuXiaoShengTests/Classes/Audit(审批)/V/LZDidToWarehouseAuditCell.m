//
//  LZDidToWarehouseAuditCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDidToWarehouseAuditCell.h"
#import "LZProcurementModel.h"

@implementation LZDidToWarehouseAuditCell

#define contentView   self.contentView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    //白色底图
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5.0f;
    //        阴影的颜色
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    //        阴影的透明度
    self.bgView.layer.shadowOpacity = 0.6f;
    //        阴影的偏移量
    self.bgView.layer.shadowOffset = CGSizeMake(4,4);
    [contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.top.equalTo(contentView).offset(10);
        make.bottom.equalTo(contentView);
    }];
    
    //头像
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.image = IMAGE(@"ordericon");
    [self.bgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(40);
        make.left.equalTo(self.bgView).offset(15);
        make.width.and.height.mas_offset(40);
    }];
    
    //头像框名字
    self.iconNameLabel = [[UILabel alloc]init];
    self.iconNameLabel.textAlignment = NSTextAlignmentCenter;
    self.iconNameLabel.font = FONT(12);
    self.iconNameLabel.textColor = [UIColor whiteColor];
    [self.iconImageView addSubview:self.iconNameLabel];
    [self.iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.iconImageView);
        make.height.mas_offset(13);
        make.width.mas_offset(37);
    }];
    
    //谁的审批
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = FONT(14);
    self.nameLabel.textColor = CD_Text33;
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.equalTo(self.bgView).offset(15);
        make.height.mas_offset(15);
        make.width.mas_offset(250);
    }];
    
    //品名
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = FONT(12);
    self.titleLabel.textColor = CD_Text66;
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(13);
        make.width.mas_offset(250);
    }];
    
    //需求量
    self.demandLabel = [[UILabel alloc]init];
    self.demandLabel.textAlignment = NSTextAlignmentLeft;
    self.demandLabel.font = FONT(12);
    self.demandLabel.textColor = CD_Text66;
    [self.bgView addSubview:self.demandLabel];
    [self.demandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(13);
        make.width.mas_offset(250);
    }];
    
    //金额
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.font = FONT(12);
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    [self.bgView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.demandLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(13);
        make.width.mas_offset(250);
    }];
    
    //时间
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = FONT(12);
    self.timeLabel.textColor = CD_Text99;
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(13);
        make.width.mas_offset(250);
    }];
    
    //审批图标
    self.auditIMV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.auditIMV];
    [self.auditIMV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(59);
        make.height.mas_offset(48);
        make.top.equalTo(self.bgView).offset(20);
        make.right.equalTo(self.bgView).offset(-15);
    }];
    
    //提示
    self.subLabel = [[UILabel alloc]init];
    self.subLabel.textColor = CD_Text99;
    self.subLabel.font = FONT(12);
    self.subLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
        make.right.equalTo(self.bgView).offset(-15);
        make.width.mas_offset(100);
        make.height.mas_offset(13);
    }];
}

- (void)setModel:(LZProcurementModel *)model{
    _model = model;
    if (_model.initiatorName.length >3) {
        self.iconNameLabel.text = [_model.initiatorName substringToIndex:3];
    }else{
        self.iconNameLabel.text = _model.initiatorName;
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@的报销",_model.initiatorName];
    self.titleLabel.text = [NSString stringWithFormat:@"品名：%@",_model.productName];
    self.demandLabel.text = [NSString stringWithFormat:@"入库量：%@",_model.houseNum];
    self.priceLabel.text = [NSString stringWithFormat:@"金额：￥%@",_model.receivableAmount];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"金额："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text66 range:oneRange];
    self.priceLabel.attributedText = temgpStr;
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    if ([_model.handleStatus integerValue] == 1) {
        self.auditIMV.image = IMAGE(@"auditYes");
    }else if ([_model.handleStatus integerValue] == 2){
        self.auditIMV.image = IMAGE(@"auditNo");
    }
//    审批类型(0：采购单 1：加工单)
    if ([_model.type integerValue] == 0) {
        self.subLabel.text = @"采购入库";
    }else if ([_model.type integerValue] == 1){
        self.subLabel.text = @"加工入库";
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
