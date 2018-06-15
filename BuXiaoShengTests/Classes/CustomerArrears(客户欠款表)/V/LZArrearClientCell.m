//
//  LZArrearClientCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZArrearClientCell.h"
#import "LZArrearClientModel.h"

@implementation LZArrearClientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _oneLbl = [[UILabel alloc]init];
    _oneLbl.font = FONT(14);
    _oneLbl.textColor = CD_Text33;
    _oneLbl.textAlignment = NSTextAlignmentCenter;
    _oneLbl.text = @"客户名称";
    //    _oneLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.contentView addSubview:_oneLbl];
    [_oneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _twoLbl = [[UILabel alloc]init];
    _twoLbl.font = FONT(14);
    _twoLbl.textColor = CD_Text33;
    _twoLbl.textAlignment = NSTextAlignmentCenter;
    _twoLbl.text = @"应收借欠";
    //    _twoLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    
    [self.contentView addSubview:_twoLbl];
    [_twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oneLbl.mas_right);
        make.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    
    _threeLbl = [[UILabel alloc]init];
    _threeLbl.font = FONT(14);
    _threeLbl.textColor = CD_Text33;
    _threeLbl.textAlignment = NSTextAlignmentCenter;
    _threeLbl.text = @"最后还款日期";
    //    _threeLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.contentView addSubview:_threeLbl];
    [_threeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_twoLbl.mas_right);
        make.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    
    _fourLbl = [[UILabel alloc]init];
    _fourLbl.font = FONT(14);
    _fourLbl.textColor = CD_Text33;
    _fourLbl.textAlignment = NSTextAlignmentCenter;
    _fourLbl.text = @"业务员";
    //    _fourLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    
    [self.contentView addSubview:_fourLbl];
    [_fourLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_threeLbl .mas_right);
        make.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
}

- (void)setModel:(LZArrearClientModel *)model{
    _model = model;
    _oneLbl.text = _model.customerName;
    _twoLbl.text = _model.arrear;
    //    _threeLbl.text = _model.repayment;
    if (_model.repayment.length >8) {
        _threeLbl.text = [_model.repayment substringFromIndex:8];
    }else{
        _threeLbl.text = _model.repayment;
    }
    _threeLbl.text = [BXSTools stringFromTData:_threeLbl.text];
    _fourLbl.text = _model.salesmanName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
