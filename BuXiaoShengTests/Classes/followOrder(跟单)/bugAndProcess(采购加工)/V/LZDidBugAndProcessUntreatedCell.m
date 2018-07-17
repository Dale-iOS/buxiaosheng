//
//  LZDidBugAndProcessUntreatedCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDidBugAndProcessUntreatedCell.h"
#import "LZBugAndProcessBssModel.h"

@implementation LZDidBugAndProcessUntreatedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        
        [self setLayout];
        
    }
    return self;
}

- (void)setLayout{
    ///白色底图
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5.0f;
//    //        阴影的颜色
//    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
//    //        阴影的透明度
//    _bgView.layer.shadowOpacity = 0.6f;
//    //        阴影的偏移量
//    _bgView.layer.shadowOffset = CGSizeMake(4,4);
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
//        make.width.mas_offset(APPWidth -15*2);
        make.height.mas_offset(112);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    //头像
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.image = IMAGE(@"ordericon");
    [_bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(40);
        make.left.equalTo(_bgView).offset(15);
        make.centerY.equalTo(_bgView);
    }];
    
    //头像名字
    _iconNameLabel = [[UILabel alloc]init];
    _iconNameLabel.backgroundColor = [UIColor clearColor];
    _iconNameLabel.textAlignment = NSTextAlignmentCenter;
    _iconNameLabel.font = FONT(12);
    _iconNameLabel.textColor = [UIColor whiteColor];
    [_iconImageView addSubview:_iconNameLabel];
    [_iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.and.centerY.equalTo(_iconImageView);
        make.height.mas_offset(13);
        make.width.mas_offset(37);
    }];
    
    //标题
    _titleLabel = [[UILabel alloc]init];
    //    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = FONT(14);
    _titleLabel.textColor = CD_Text33;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top).offset(15);
        make.left.equalTo(_iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    //内容 副标题
    _subLabel = [[UILabel alloc]init];
    //    _subLabel.backgroundColor = [UIColor yellowColor];
    _subLabel.textAlignment = NSTextAlignmentLeft;
    _subLabel.font = FONT(12);
    _subLabel.textColor = CD_Text66;
    [_bgView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //需求量
    _demandLabel = [[UILabel alloc]init];
    //    _demandLabel.backgroundColor = [UIColor greenColor];
    _demandLabel.textAlignment = NSTextAlignmentLeft;
    _demandLabel.font = FONT(12);
    _demandLabel.textColor = CD_Text66;
    [_bgView addSubview:_demandLabel];
    [_demandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //时间
    _timeLabel = [[UILabel alloc]init];
    //    _timeLabel.backgroundColor = [UIColor blueColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = CD_Text99;
    [_bgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_demandLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconImageView.mas_right).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //状态
    _stateLabel = [[UILabel alloc]init];
//    _stateLabel.backgroundColor = [UIColor blueColor];
    _stateLabel.textAlignment = NSTextAlignmentRight;
    _stateLabel.font = FONT(12);
    _stateLabel.textColor = [UIColor colorWithHexString:@"#25cce5"];
    [_bgView addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_demandLabel.mas_bottom).offset(10);
        make.right.equalTo(_bgView).offset(-15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
}

- (void)setModel:(LZBugAndProcessBssModel *)model{
    _model = model;
    
    if (_model.initiatorName.length >3) {
        _iconNameLabel.text = [_model.initiatorName substringToIndex:3];
    }else{
        _iconNameLabel.text = _model.initiatorName;
    }
    _titleLabel.text = _model.factoryName;
    _subLabel.text = [NSString stringWithFormat:@"品名：%@",_model.productName];
    _demandLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.number];
    _timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    //    采购类型（0：采购 1：加工）
    if ([_model.purchaseType integerValue] == 0) {
        _stateLabel.text = @"采购";
    }else if ([_model.purchaseType integerValue] == 1)
    {
        _stateLabel.text = @"加工";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
