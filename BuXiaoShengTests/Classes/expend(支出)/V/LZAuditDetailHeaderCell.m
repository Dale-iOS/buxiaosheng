//
//  LZAuditDetailHeaderCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZAuditDetailHeaderCell.h"

@implementation LZAuditDetailHeaderCell
@synthesize headerImageView,headerTitle,nameLabel,state;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (UIImageView *)headerImageView{
    if (headerImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self addSubview:(headerImageView = imageView)];
    }
    return headerImageView;
}

- (UILabel *)headerTitle{
    if (headerTitle == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor whiteColor];
        [self addSubview:(headerTitle = label)];
    }
    return headerTitle;
}

- (UILabel *)nameLabel{
    if (nameLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self addSubview:(nameLabel = label)];
    }
    return nameLabel;
}

- (UILabel *)state{
    if (state == nil) {
        UILabel *label = [[UILabel alloc]init];
//        label.backgroundColor = [UIColor colorWithHexString:@"#25cce5" alpha:0.2];
//        label.textColor = [UIColor colorWithHexString:@"#25cce5"];
        label.layer.cornerRadius = 2.0f;
        label.layer.masksToBounds = YES;
        label.font = FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:(state = label)];
    }
    return state;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(40);
        make.left.mas_equalTo(self).offset(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerImageView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(15);
        make.top.mas_equalTo(self).offset(18);
        make.right.mas_equalTo(self).offset(15);
        make.height.mas_offset(15);
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
}

- (void)setModel:(LZAuditDetailModel *)model{
    _model = model;
    
    NSString *tempStr =_model.approverName;
    if (tempStr.length >3) {
        self.headerTitle.text = [tempStr substringToIndex:3];
    }else{
        self.headerTitle.text = _model.approverName;
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"申请人：%@",_model.initiatorName];
    switch ([_model.status integerValue]) {
        case -1:
            //已取消
            self.state.text = @"已撤销审批";
            self.state.backgroundColor = [UIColor colorWithHexString:@"##ff6565" alpha:0.2];
            self.state.textColor = [UIColor colorWithHexString:@"##ff6565"];
            break;
        case 0:
            //待审批
            self.state.text = [NSString stringWithFormat:@"等待%@审批",_model.approverName];
            self.state.backgroundColor = [UIColor colorWithHexString:@"#25cce5" alpha:0.2];
            self.state.textColor = [UIColor colorWithHexString:@"#25cce5"];
            break;
        case 1:
            //通过
            self.state.text = @"已同意审批";
            self.state.backgroundColor = [UIColor colorWithHexString:@"#25cce5" alpha:0.2];
            self.state.textColor = [UIColor colorWithHexString:@"#25cce5"];
            break;
        case 2:
            //拒绝
            self.state.text = @"已拒绝审批";
            self.state.backgroundColor = [UIColor colorWithHexString:@"##ff6565" alpha:0.2];
            self.state.textColor = [UIColor colorWithHexString:@"##ff6565"];
            break;
            
        default:
            break;
    }
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(self.state.text.length*13 +3);
    }];
}

@end
