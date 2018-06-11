//
//  LZSpendingListCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSpendingListCell.h"
#import "LZSpendingModel.h"

@implementation LZSpendingListCell
{
    UILabel *_costLbl;//费用
    UILabel *_bankPayLbl;//银行方式
    UILabel *_dateLbl;//日期
    UILabel *_money;//费用
    UIImageView *_auditYesIM;//审批通过图标
    UIImageView *_auditNoIM;//审批拒绝图标
    UILabel *_waitAuditLbl;//待审批状态
    UILabel *_didRevocationLbl;//已撤销状态
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //费用
    _costLbl = [[UILabel alloc]init];
    _costLbl.font = FONT(14);
    _costLbl.textColor = CD_Text33;
    [self.contentView addSubview:_costLbl];
    [_costLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    //银行方式
    _bankPayLbl = [[UILabel alloc]init];
    _bankPayLbl.font = FONT(13);
    _bankPayLbl.textColor = CD_Text66;
    [self.contentView addSubview:_bankPayLbl];
    [_bankPayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_costLbl).offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(14);
    }];
    
    //日期
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.textColor = CD_Text66;
    _dateLbl.font = FONT(13);
    [self.contentView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_bankPayLbl.mas_bottom).offset(10);
        make.height.mas_offset(14);
        make.width.mas_offset(100);
    }];
    
    //费用
    _money = [[UILabel alloc]init];
    _money.font = FONT(17);
    _money.textColor = CD_Text33;
    [self.contentView addSubview:_money];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(115);
        make.height.mas_offset(18);
        make.width.mas_offset(100);
        make.centerY.equalTo(self.contentView);
    }];
    
    //审批通过图
    _auditYesIM = [[UIImageView alloc]init];
    _auditYesIM.image = IMAGE(@"auditYes");
    _auditYesIM.backgroundColor = [UIColor clearColor];
    _auditYesIM.hidden = YES;
    [self.contentView addSubview:_auditYesIM];
    [_auditYesIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(59);
        make.height.mas_offset(48);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    //审批通过图
    _auditNoIM = [[UIImageView alloc]init];
    _auditNoIM.image = IMAGE(@"auditNo");
//    _auditNoIM.backgroundColor = [UIColor clearColor];
    _auditNoIM.hidden = YES;
    [self.contentView addSubview:_auditNoIM];
    [_auditNoIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(59);
        make.height.mas_offset(48);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    //待审批状态
    _waitAuditLbl = [[UILabel alloc]init];
    _waitAuditLbl.layer.cornerRadius = 2.0f;
    _waitAuditLbl.layer.masksToBounds = YES;
    _waitAuditLbl.layer.borderColor = [[UIColor colorWithRed:37.0f/255.0f green:204.0f/255.0f blue:229.0f/255.0f alpha:0.2f] CGColor];
    _waitAuditLbl.backgroundColor = [UIColor colorWithRed:37.0f/255.0f green:204.0f/255.0f blue:229.0f/255.0f alpha:0.2f];
    _waitAuditLbl.font = FONT(12);
    _waitAuditLbl.textColor = [UIColor colorWithHexString:@"#25cce5"];
    _waitAuditLbl.textAlignment = NSTextAlignmentCenter;
    _waitAuditLbl.text = @"待审批";
    _waitAuditLbl.hidden = YES;
    [self.contentView addSubview:_waitAuditLbl];
    [_waitAuditLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    //已撤销状态
    _didRevocationLbl = [[UILabel alloc]init];
    _didRevocationLbl.layer.cornerRadius = 2.0f;
    _didRevocationLbl.layer.masksToBounds = YES;
    _didRevocationLbl.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f] CGColor];
    _didRevocationLbl.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f];
    _didRevocationLbl.font = FONT(12);
    _didRevocationLbl.textColor = [UIColor colorWithHexString:@"#ff6565"];
    _didRevocationLbl.textAlignment = NSTextAlignmentCenter;
    _didRevocationLbl.text = @"已撤销";
    _didRevocationLbl.hidden = YES;
    [self.contentView addSubview:_didRevocationLbl];
    [_didRevocationLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];

}

- (void)setModel:(LZSpendingDetailModel *)model{
    _model = model;
    _costLbl.text = _model.costsubjectName;
    _bankPayLbl.text = _model.bankName;
    _dateLbl.text = [BXSTools stringFromTData:_model.tallyTime];
    _money.text = [NSString stringWithFormat:@"-%@",_model.amount];
    //状态（-1:已取消 0：待审批 1：通过 2：拒绝
    switch ([_model.status integerValue]) {
        case -1:
            _auditYesIM.hidden = YES;
            _auditNoIM.hidden = YES;
            _waitAuditLbl.hidden = YES;
            _didRevocationLbl.hidden = NO;;
            break;
        case 0:
            _auditYesIM.hidden = YES;
            _auditNoIM.hidden = YES;
            _waitAuditLbl.hidden = NO;
            _didRevocationLbl.hidden = YES;;
            break;
        case 1:
            _auditYesIM.hidden = NO;
            _auditNoIM.hidden = YES;
            _waitAuditLbl.hidden = YES;
            _didRevocationLbl.hidden = YES;;
            break;
        case 2:
            _auditYesIM.hidden = YES;
            _auditNoIM.hidden = NO;
            _waitAuditLbl.hidden = YES;
            _didRevocationLbl.hidden = YES;;
            break;
        default:
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
