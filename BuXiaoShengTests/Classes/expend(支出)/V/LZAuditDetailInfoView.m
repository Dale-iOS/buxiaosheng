//
//  LZAuditDetailInfoView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZAuditDetailInfoView.h"
#import "UITextView+Placeholder.h"

@implementation LZAuditDetailInfoView
@synthesize timeLabel,typeLabel,moneyLabel,approverLabel,remarkTestView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (TextInputCell *)timeLabel{
    if (timeLabel == nil) {
        TextInputCell *temp = [[TextInputCell alloc]init];
        temp.titleLabel.text = @"时间：";
        temp.titleLabel.textColor = CD_Text33;
        temp.titleLabel.font = FONT(14);
        temp.lineView.hidden = YES;
        temp.userInteractionEnabled = NO;
        [self addSubview:(timeLabel = temp)];
    }
    return timeLabel;
}

- (TextInputCell *)typeLabel{
    if (typeLabel == nil) {
        TextInputCell *temp = [[TextInputCell alloc]init];
        temp.titleLabel.text = @"开销类型：";
        temp.titleLabel.textColor = CD_Text33;
        temp.titleLabel.font = FONT(14);
        temp.lineView.hidden = YES;
        temp.userInteractionEnabled = NO;
        [self addSubview:(typeLabel = temp)];
    }
    return typeLabel;
}

- (TextInputCell *)moneyLabel{
    if (moneyLabel == nil) {
        TextInputCell *temp = [[TextInputCell alloc]init];
        temp.titleLabel.text = @"金额：";
        temp.titleLabel.textColor = CD_Text33;
        temp.titleLabel.font = FONT(14);
        temp.contentTF.textColor = LZAppRedColor;
        temp.lineView.hidden = YES;
        temp.userInteractionEnabled = NO;
        [self addSubview:(moneyLabel = temp)];
    }
    return moneyLabel;
}

- (TextInputCell *)approverLabel{
    if (approverLabel == nil) {
        TextInputCell *temp = [[TextInputCell alloc]init];
        temp.titleLabel.text = @"审批人：";
        temp.titleLabel.textColor = CD_Text33;
        temp.titleLabel.font = FONT(14);
        temp.lineView.hidden = YES;
        temp.userInteractionEnabled = NO;
        [self addSubview:(approverLabel = temp)];
    }
    return approverLabel;
}

- (TextInputTextView *)remarkTestView{
    if (remarkTestView == nil) {
        TextInputTextView *temp = [[TextInputTextView alloc]init];
        temp.titleLabel.text = @"备注：";
        temp.titleLabel.textColor = CD_Text33;
        temp.titleLabel.font = FONT(14);
        temp.lineView.hidden = YES;
        temp.userInteractionEnabled = NO;
        [self addSubview:(remarkTestView = temp)];
    }
    return remarkTestView;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];

    [self.approverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];

    [self.remarkTestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.approverLabel.mas_bottom).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(70);
    }];
}

- (void)setModel:(LZAuditDetailModel *)model{
    _model = model;
    self.timeLabel.contentTF.text = [BXSTools stringFromTData:_model.tallyTime];
    self.typeLabel.contentTF.text = _model.costsubjectName;
    self.moneyLabel.contentTF.text = [NSString stringWithFormat:@"￥%@",_model.amount];
    self.approverLabel.contentTF.text = _model.approverName;
    self.remarkTestView.textView.text = _model.remark;
}

@end
