//
//  LZBugAndProcessUntreatedCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBugAndProcessUntreatedCell.h"
#import "LZBugAndProcessBssModel.h"

@implementation LZBugAndProcessUntreatedCell

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
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_offset(APPWidth -15*2);
        make.height.mas_offset(140);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    //头像
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.image = IMAGE(@"ordericon");
    [_bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(40);
        make.left.equalTo(_bgView).offset(15);
        make.top.equalTo(_bgView).offset(28);
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
        make.top.equalTo(_bgView.mas_top).offset(20);
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
    
    //线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = LZHBackgroundColor;
    [_bgView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView);
        make.top.equalTo(_bgView.mas_top).offset(95);
        make.height.mas_offset(0.5);
        make.width.mas_offset(APPWidth -15*2);
    }];
    
    //完成按钮（第三个按钮）
    _completeBtn = [[UIButton alloc]init];
    _completeBtn.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    _completeBtn.layer.cornerRadius = 5.0f;
    _completeBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _completeBtn.layer.borderWidth = 0.5;
    _completeBtn.titleLabel.font = FONT(13);
    _completeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeBtn addTarget:self action:@selector(thridBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_bgView addSubview:_completeBtn];
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-10);
    }];
    
    //采购询问（第二个按钮）
    _askBtn = [[UIButton alloc]init];
    _askBtn.backgroundColor = [UIColor whiteColor];
    _askBtn.layer.cornerRadius = 5.0f;
    _askBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _askBtn.layer.borderWidth = 0.5;
    _askBtn.titleLabel.font = FONT(13);
    _askBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_askBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
    [_askBtn addTarget:self action:@selector(secondBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_askBtn setTitle:@"采购询问" forState:UIControlStateNormal];
    [_bgView addSubview:_askBtn];
    [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_completeBtn.mas_left).offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-10);
    }];
    
    //采购收货（第一个按钮）
    _receiptBtn = [[UIButton alloc]init];
    _receiptBtn.backgroundColor = [UIColor whiteColor];
    _receiptBtn.layer.cornerRadius = 5.0f;
    _receiptBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _receiptBtn.layer.borderWidth = 0.5;
    _receiptBtn.titleLabel.font = FONT(13);
    _receiptBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_receiptBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
    [_receiptBtn addTarget:self action:@selector(firstBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_receiptBtn setTitle:@"采购收货" forState:UIControlStateNormal];
    [_bgView addSubview:_receiptBtn];
    [_receiptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_askBtn.mas_left).offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-10);
    }];
    
    //时间
    _timeLabel = [[UILabel alloc]init];
//    _timeLabel.backgroundColor = [UIColor blueColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = CD_Text99;
    _timeLabel.numberOfLines = 2;
    [_bgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(2);
        make.left.equalTo(_bgView).offset(15);
        make.right.equalTo(_receiptBtn.mas_left).offset(-15);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-5);
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
//    NSString *tempTimeStr = [BXSTools getTimeStrWithString:_model.createTime];
    //截取10之前的字符串
    NSString *timeA = [[BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]] substringToIndex:10];
    //截取11之后的字符串
    NSString *timeB = [[BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]] substringFromIndex:11];
    _timeLabel.text = [NSString stringWithFormat:@"%@\n%@",timeA,timeB];
//    采购类型（0：采购 1：加工）
    if ([_model.purchaseType integerValue] == 0) {
        [_receiptBtn setTitle:@"采购收货" forState:UIControlStateNormal];
        [_askBtn setTitle:@"采购询问" forState:UIControlStateNormal];
    }else if ([_model.purchaseType integerValue] == 1)
    {
        [_receiptBtn setTitle:@"加工收货" forState:UIControlStateNormal];
        [_askBtn setTitle:@"加工询问" forState:UIControlStateNormal];
    }
}

- (void)firstBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickFirstBtnInCell:)]) {
        [self.delegate didClickFirstBtnInCell:self];
    }
}

- (void)secondBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickSecondBtnInCell:)]) {
        [self.delegate didClickSecondBtnInCell:self];
    }
}

- (void)thridBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickThirdBtnInCell:)]) {
        [self.delegate didClickThirdBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
