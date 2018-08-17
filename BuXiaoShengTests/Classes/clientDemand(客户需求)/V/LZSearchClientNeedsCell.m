//
//  LZSearchClientNeedsCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSearchClientNeedsCell.h"
#import "LZOrderTrackingModel.h"

@implementation LZSearchClientNeedsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //头像图标
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.image = IMAGE(@"ordericon");
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(40);
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    //头像图标白色文字
    self.iconNameLabel = [[UILabel alloc]init];
    self.iconNameLabel.textAlignment = NSTextAlignmentCenter;
    self.iconNameLabel.font = FONT(12);
    self.iconNameLabel.textColor = [UIColor whiteColor];
    [self.iconImageView addSubview:self.iconNameLabel];
    [self.iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.centerX.equalTo(self.iconImageView);
        make.width.mas_offset(40);
        make.height.mas_offset(14);
    }];
    
    //厂名
    self.companyLabel = [[UILabel alloc]init];
    //    self.companyLabel.backgroundColor = [UIColor redColor];
    self.companyLabel.textAlignment = NSTextAlignmentLeft;
    self.companyLabel.font = FONT(14);
    self.companyLabel.textColor = CD_Text33;
    [self.contentView addSubview:self.companyLabel];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(150);
        make.height.mas_offset(15);
    }];
    
    //品名
    self.nameLabel = [[UILabel alloc]init];
    //    self.nameLabel.backgroundColor = [UIColor orangeColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = FONT(12);
    self.nameLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //需求量
    self.needLabel = [[UILabel alloc]init];
    //    self.needLabel.backgroundColor = [UIColor yellowColor];
    self.needLabel.textAlignment = NSTextAlignmentLeft;
    self.needLabel.font = FONT(12);
    self.needLabel.textColor = CD_Text66;
    [self.contentView addSubview:self.needLabel];
    [self.needLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(13);
    }];
    
    //价格
    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.backgroundColor = [UIColor grayColor];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.font = FONT(12);
    self.priceLabel.textColor = LZAppRedColor;
    self.priceLabel.text = @"￥";
    self.priceLabel.hidden = YES;
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView).offset(140);
        make.width.mas_offset(100);
        make.height.mas_offset(13);
    }];
    
    //状态
    self.stateLabel = [[UILabel alloc]init];
    //    self.stateLabel.backgroundColor = [UIColor blueColor];
    self.stateLabel.textAlignment = NSTextAlignmentRight;
    self.stateLabel.font = FONT(12);
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#25cce5"];
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_offset(100);
        make.height.mas_offset(13);
    }];
    
    //日期
    self.dateLabel = [[UILabel alloc]init];
    //    self.dateLabel.backgroundColor = [UIColor greenColor];
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    self.dateLabel.font = FONT(12);
    self.dateLabel.textColor = CD_Text99;
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_offset(130);
        make.height.mas_offset(13);
    }];
}

- (void)setModel:(LZOrderTrackingModel *)model{
    _model = model;
    if (_model.drawerName.length >3) {
        self.iconNameLabel.text = [_model.drawerName substringToIndex:3];
    }else{
        self.iconNameLabel.text = _model.drawerName;
    }
    self.companyLabel.text = _model.customerName;
    self.nameLabel.text = _model.productName;
    self.needLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.number];
    self.priceLabel.text = [NSString stringWithFormat:@"￥：%@",_model.price];
    switch ([_model.orderStatus integerValue]) {
        case -2:
            self.stateLabel.text = @"已取消";
            break;
        case -1:
            self.stateLabel.text = @"撤销审核中";
            break;
        case -0:
            self.stateLabel.text = @"待出库";
            break;
        case 1:
            self.stateLabel.text = @"已出库";
            break;
        case 2:
            self.stateLabel.text = @"派送";
            break;
        case 3:
            self.stateLabel.text = @"待出货";
            break;
        case 4:
            self.stateLabel.text = @"已交货";
            break;
        case 5:
            self.stateLabel.text = @"完成";
            break;
        default:
            break;
    }
    self.dateLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
