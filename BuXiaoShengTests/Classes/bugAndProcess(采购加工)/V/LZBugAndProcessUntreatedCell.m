//
//  LZBugAndProcessUntreatedCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBugAndProcessUntreatedCell.h"

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
        make.left.and.right.equalTo(self.contentView).offset(15);
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
    _iconNameLabel.textAlignment = NSTextAlignmentCenter;
    _iconNameLabel.font = FONT(12);
    _iconNameLabel.textColor = [UIColor whiteColor];
    [_iconImageView addSubview:_iconNameLabel];
    [_iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.and.centerY.equalTo(_iconImageView);
    }];
    
    //标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = FONT(14);
    _titleLabel.textColor = CD_Text33;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top).offset(20);
        make.left.equalTo(_iconImageView).offset(15);
        make.width.mas_offset(150);
        make.height.mas_offset(15);
    }];
    
    //内容 副标题
    _subLabel = [[UILabel alloc]init];
    _subLabel.textAlignment = NSTextAlignmentLeft;
    _subLabel.font = FONT(12);
    _subLabel.textColor = CD_Text66;
    [_bgView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconImageView).offset(15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
    
    //需求量
    _demandLabel = [[UILabel alloc]init];
    _demandLabel.textAlignment = NSTextAlignmentLeft;
    _demandLabel.font = FONT(12);
    _demandLabel.textColor = CD_Text66;
    [_bgView addSubview:_demandLabel];
    [_demandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconImageView).offset(15);
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
    
    //时间
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = CD_Text99;
    [_bgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subLabel.mas_bottom).offset(15);
        make.left.equalTo(_iconImageView).offset(15);
        make.width.mas_offset(150);
        make.height.mas_offset(13);
    }];
    
    //完成按钮
    _completeBtn = [[UIButton alloc]init];
    _completeBtn.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    _completeBtn.layer.cornerRadius = 5.0f;
    _completeBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _completeBtn.layer.borderWidth = 0.5;
    _completeBtn.titleLabel.font = FONT(13);
    _completeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_completeBtn];
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-15);
        make.width.mas_offset(69);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-15);
    }];
    
    //采购询问
    _askBtn = [[UIButton alloc]init];
    _askBtn.backgroundColor = [UIColor whiteColor];
    _askBtn.layer.cornerRadius = 5.0f;
    _askBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _askBtn.layer.borderWidth = 0.5;
    _askBtn.titleLabel.font = FONT(13);
    _askBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_askBtn];
    [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_completeBtn.mas_left).offset(15);
        make.width.mas_offset(69);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-15);
    }];
    
    //采购收货
    _receiptBtn = [[UIButton alloc]init];
    _receiptBtn.backgroundColor = [UIColor whiteColor];
    _receiptBtn.layer.cornerRadius = 5.0f;
    _receiptBtn.layer.borderColor = [UIColor colorWithHexString:@"#3d9bfa"].CGColor;
    _receiptBtn.layer.borderWidth = 0.5;
    _receiptBtn.titleLabel.font = FONT(13);
    _receiptBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_receiptBtn];
    [_receiptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_askBtn.mas_left).offset(15);
        make.width.mas_offset(69);
        make.height.mas_offset(29);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-15);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
