//
//  LLAddNewsPeopleCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddNewsPeopleCollectionViewCell.h"
#import "LLAddNewPeoleRoleModel.h"

@implementation LLAddNewsPeopleCollectionViewCell
{
    UIImageView  * _logoImgaeView;
    UILabel * _titleLable;
    
    UIButton * _deleteBtn;
}

-(void)setModel:(LLAddNewPeoleRoleModel *)model {
    _model = model;
    [_logoImgaeView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@""]];
    _titleLable.text = _model.name;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    _logoImgaeView = [UIImageView new];
    [self.contentView addSubview:_logoImgaeView];
    [_logoImgaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.width.mas_equalTo(49);
    }];
    
    _titleLable = [UILabel new];
    [self.contentView addSubview:_titleLable];
    _titleLable.textColor = [UIColor darkGrayColor];
    _titleLable.font = [UIFont systemFontOfSize:15];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgaeView.mas_bottom).offset(5);
        make.centerX.equalTo(_logoImgaeView);
    }];
    
    _deleteBtn = [UIButton new];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
   // [_deleteBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_deleteBtn setBackgroundColor:[UIColor redColor]];
    _deleteBtn.layer.masksToBounds = true;
    _deleteBtn.layer.cornerRadius = 10;
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:5];
    _deleteBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgaeView.mas_top).offset(-2);
        make.left.equalTo(_logoImgaeView.mas_left).offset(-3);
        make.width.height.mas_equalTo(20);
    }];
}
-(void)deleteBtnClick {
    
    self.block(self);
}
@end
