//
//  LLAddNewsPeopleSectionView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddNewsPeopleSectionView.h"
#import "LLAddNewPeoleRoleModel.h"
@implementation LLAddNewsPeopleSectionView
{
    UILabel * _titleLable;
    
    UIButton * _addPermissions;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(LLAddNewPeoleRoleModel *)model {
    _model = model;
    _titleLable.text = _model.name;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    UIView * contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    _titleLable = [UILabel new];
    [contentView addSubview:_titleLable];
    _titleLable.font = [UIFont systemFontOfSize:15];
    _titleLable.textColor = [UIColor darkGrayColor];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15);
        make.centerY.equalTo(contentView);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(contentView);
        make.height.mas_equalTo(1);
    }];
    
    _addPermissions  = [UIButton new];
    [_addPermissions addTarget:self action:@selector(addPermissionsClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_addPermissions];
    [_addPermissions setBackgroundImage:[UIImage imageNamed:@"add1"] forState:UIControlStateNormal];
    [_addPermissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.centerY.equalTo(contentView);
    }];
    
}

-(void)addPermissionsClick {
    self.block(self);
}




@end
