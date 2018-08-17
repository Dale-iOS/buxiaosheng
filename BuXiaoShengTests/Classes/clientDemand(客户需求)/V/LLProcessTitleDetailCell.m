//
//  LLProcessTitleDetailCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLProcessTitleDetailCell.h"

@implementation LLProcessTitleDetailCell
{
    UILabel * _leftcolorLable;
    UILabel * _leftdemandLable;
    UILabel * _rightcolorLable;
    UILabel * _rightdemandLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    _leftcolorLable = [UILabel new];
    [self.contentView addSubview:_leftcolorLable];
    _leftcolorLable.textColor = CD_Text33;
    _leftcolorLable.font = [UIFont systemFontOfSize:15];
    _leftcolorLable.text = @"红色";
    _leftcolorLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_leftcolorLable];
    [_leftcolorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.25);
    }];
    
    _leftdemandLable = [UILabel new];
    [self.contentView addSubview:_leftdemandLable];
    _leftdemandLable.textColor = CD_Text33;
    _leftdemandLable.font = [UIFont systemFontOfSize:15];
    _leftdemandLable.text = @"698802";
    _leftdemandLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_leftdemandLable];
    [_leftdemandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftcolorLable.mas_right);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.25);
    }];
    
    
    _rightdemandLable = [UILabel new];
    [self.contentView addSubview:_leftdemandLable];
    _rightdemandLable.textColor = CD_Text33;
    _rightdemandLable.font = [UIFont systemFontOfSize:15];
    _rightdemandLable.text = @"蓝色";
    _rightdemandLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_rightdemandLable];
    [_rightdemandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftdemandLable.mas_right);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.25);
    }];
    
    _rightcolorLable = [UILabel new];
    [self.contentView addSubview:_rightcolorLable];
    _rightcolorLable.textColor = CD_Text33;
    _rightcolorLable.font = [UIFont systemFontOfSize:15];
    _rightcolorLable.text = @"123456";
    _rightcolorLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_rightcolorLable];
    [_rightcolorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightdemandLable.mas_right);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.25);
    }];
}

@end
