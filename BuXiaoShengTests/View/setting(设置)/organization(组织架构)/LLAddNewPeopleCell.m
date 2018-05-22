//
//  LLAddNewPeopleCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddNewPeopleCell.h"
#import "LLAddNewPeopleModel.h"
@implementation LLAddNewPeopleCell
{
    UILabel * _leftLable;
    UITextField * _rightTextFild;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(LLAddNewPeopleModel *)model {
    _model = model;
      _rightTextFild.enabled = true;
     self.accessoryType = UITableViewCellAccessoryNone;
    switch (self.indexPath.row) {
        case 0:
            _leftLable.text = @"选择部门";
            _rightTextFild.placeholder = @"请选择部门";
            _rightTextFild.text = _model.deptName;
            _rightTextFild.enabled = false;
            _rightTextFild.textColor = CD_Text33;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            _leftLable.text = @"人员名称";
            _rightTextFild.text = _model.realName;
            _rightTextFild.textColor = CD_Text33;
            break;
        case 2:
            _leftLable.text = @"账号";
//            _rightTextFild.enabled = false;
            _rightTextFild.text = _model.loginName;
            _rightTextFild.textColor = CD_Text33;
            break;
        case 3:
            _leftLable.text = @"账号登录密码";
            _rightTextFild.placeholder = @"请重新设置密码";
            _rightTextFild.secureTextEntry = YES;
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    _leftLable = [UILabel new];
    [self.contentView addSubview:_leftLable];
    _leftLable.textColor = [UIColor darkGrayColor];
    _leftLable.font = [UIFont systemFontOfSize:15];
    [_leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset (15);
        make.centerY.equalTo(self.contentView);
    }];
    
    _rightTextFild = [UITextField new];
    _rightTextFild.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_rightTextFild];
    _rightTextFild.font = [UIFont systemFontOfSize:15];
    [_rightTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(160);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
