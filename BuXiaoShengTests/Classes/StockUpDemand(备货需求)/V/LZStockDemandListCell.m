//
//  LZStockDemandListCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZStockDemandListCell.h"
#import "LZStockDemandListModel.h"

@implementation LZStockDemandListCell

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
    self.dateLabel.textAlignment = NSTextAlignmentLeft;
    self.dateLabel.font = FONT(12);
    self.dateLabel.textColor = CD_Text99;
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.needLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.width.mas_offset(300);
        make.height.mas_offset(13);
    }];
    
    //撤销
    self.stockListBtn = [[UIButton alloc]init];
    [self.stockListBtn setTitle:@"备货列表" forState:UIControlStateNormal];
    [self.stockListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.stockListBtn.layer.cornerRadius = 5.0f;
    self.stockListBtn.layer.masksToBounds = YES;
    self.stockListBtn.titleLabel.font = FONT(13);
    self.stockListBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.stockListBtn setBackgroundColor:LZAppBlueColor];
    [self.stockListBtn addTarget:self action:@selector(stockListBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.stockListBtn];
    [self.stockListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_offset(70);
        make.height.mas_offset(25);
    }];
}

- (void)setModel:(LZStockDemandListModel *)model{
    _model = model;
    //图标名字
    if (_model.initiatorName.length >3) {
        self.iconNameLabel.text = [_model.initiatorName substringToIndex:3];
    }else{
        self.iconNameLabel.text = _model.initiatorName;
    }
    //厂名
    self.companyLabel.text = _model.factoryName;
    //品名
    self.nameLabel.text = _model.productName;
    //需求量
    self.needLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.number];
    //日期
    self.dateLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    //状态
    switch ([_model.purchaseType integerValue]) {
        case 0:
            self.stateLabel.text = @"采购";
            break;
        case 1:
            self.stateLabel.text = @"加工";
            break;
        default:
            break;
    }
}

- (void)stockListBtnClick{
    if ([self.delegate respondsToSelector:@selector(didstockListBtnInCell:)]) {
        [self.delegate didstockListBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
