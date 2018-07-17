//
//  LZProcurementCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZProcurementCell.h"
#import "LZProcurementModel.h"

@implementation LZProcurementCell

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
//    //        阴影的颜色
//    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
//    //        阴影的透明度
//    self.bgView.layer.shadowOpacity = 0.6f;
//    //        阴影的偏移量
//    self.bgView.layer.shadowOffset = CGSizeMake(4,4);
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
    
    //入库数
    self.toWarehouseLabel = [[UILabel alloc]init];
    self.toWarehouseLabel.textAlignment = NSTextAlignmentLeft;
    self.toWarehouseLabel.font = FONT(12);
    self.toWarehouseLabel.textColor = CD_Text66;
    [self.bgView addSubview:self.toWarehouseLabel];
    [self.toWarehouseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(self.toWarehouseLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(13);
        make.width.mas_offset(250);
    }];
    
    //线
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = LZHBackgroundColor;
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.bgView);
        make.height.mas_offset(0.5);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
    
    //时间
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = FONT(12);
    self.timeLabel.textColor = CD_Text99;
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.top.equalTo(self.lineView.mas_bottom).offset(12);
        make.height.mas_offset(13);
        make.width.mas_offset(200);
    }];
    
    //采购入库
    self.stateLabel = [[UILabel alloc]init];
    self.stateLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f];
    self.stateLabel.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f].CGColor;
    self.stateLabel.layer.cornerRadius = 2.0f;
    self.stateLabel.layer.borderWidth = 1;
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#ff6565"];
    self.stateLabel.text = @"采购入库";
    self.stateLabel.font = FONT(12);
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-15);
        make.top.equalTo(self.bgView).offset(13);
        make.width.mas_offset(75);
        make.height.mas_offset(20);
    }];
    
    //进入审批按钮
    self.goAuditBtn = [[UIButton alloc]init];
    [self.goAuditBtn setBackgroundColor:LZAppBlueColor];
    [self.goAuditBtn setTitle:@"进入审批" forState:UIControlStateNormal];
    self.goAuditBtn.titleLabel.font = FONT(13);
    self.goAuditBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.goAuditBtn.layer.cornerRadius = 5.0f;
    self.goAuditBtn.layer.borderColor = LZAppBlueColor.CGColor;
    self.goAuditBtn.layer.masksToBounds = YES;
    [self.goAuditBtn addTarget:self action:@selector(goAuditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.goAuditBtn];
    [self.goAuditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-15);
        make.top.equalTo(self.lineView).offset(7);
        make.width.mas_offset(70);
        make.height.mas_offset(29);
    }];
    
}

- (void)setModel:(LZProcurementModel *)model{
    _model = model;
    if (_model.initiatorName.length >3) {
        self.iconNameLabel.text = [_model.initiatorName substringToIndex:3];
    }else{
        self.iconNameLabel.text = _model.initiatorName;
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@的审批",_model.initiatorName];
    self.titleLabel.text = [NSString stringWithFormat:@"品名：%@",_model.productName];
    self.toWarehouseLabel.text = [NSString stringWithFormat:@"入库量：%@",_model.houseNum];
    self.priceLabel.text = [NSString stringWithFormat:@"金额：￥%@",_model.houseNum];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"金额："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text66 range:oneRange];
    self.priceLabel.attributedText = temgpStr;
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
}

- (void)goAuditBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickgoAuditBtnInCell:)]) {
        [self.delegate didClickgoAuditBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
