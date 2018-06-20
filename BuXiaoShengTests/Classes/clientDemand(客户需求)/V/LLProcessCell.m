//
//  LLProcessCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLProcessCell.h"

@implementation LLProcessCell
{
    UILabel * _leftLable;
    UILabel * _rightLable;
}

-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.section == 2) {
        _leftLable.text = [self.datas[indexPath.row] objectForKey:@"key"];
        self.accessoryType = UITableViewCellAccessoryNone;
        if ([self.datas[indexPath.row][@"value"]isEqualToString:@""]) {
            self.textField.hidden = false;
            _rightLable.hidden = true;
            switch (indexPath.row) {
                case 0:
                    self.textField.placeholder = @"请输入厂商信息";
                    break;
                case 1:
                    self.textField.placeholder = @"请输入联系人名称";
                    break;
                case 2:
                    self.textField.placeholder = @"请输入电话";
                    break;
                case 3:
                    self.textField.placeholder = @"请填写地址";
                    break;
            }
        }else {
            self.textField.hidden = true;
            _rightLable.hidden = false;
            _rightLable.text = self.datas[indexPath.row][@"value"];
            if ([self.datas[indexPath.row][@"type"]isEqualToString:@"1"]) {
                _rightLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
            }else if ([self.datas[indexPath.row][@"type"]isEqualToString:@"2"]){
                _rightLable.textColor = [UIColor redColor];
            }else if ([self.datas[indexPath.row][@"type"]isEqualToString:@"0"]) {
                _rightLable.textColor = [UIColor colorWithHexString:@"#333333"];
            }
        }
    }else if (indexPath.section == 3) {
        _leftLable.text = [self.datas[indexPath.row] objectForKey:@"key"];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.textField.hidden = true;
            _rightLable.hidden = false;
            _rightLable.text = self.datas[indexPath.row][@"value"];
            if ([self.datas[indexPath.row][@"type"]isEqualToString:@"1"]) {
                _rightLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
            }else if ([self.datas[indexPath.row][@"type"]isEqualToString:@"2"]){
                _rightLable.textColor = [UIColor redColor];
            }else if ([self.datas[indexPath.row][@"type"]isEqualToString:@"0"]) {
                _rightLable.textColor = [UIColor colorWithHexString:@"#333333"];
            }
       
    }else if(indexPath.section == 4) {
        _leftLable.text = [self.datas[indexPath.row] objectForKey:@"key"];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.textField.placeholder = @"请输入备注内容";
        self.textField.hidden = false;
        _rightLable.hidden = true;

    }
    
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
    _leftLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _leftLable.font = [UIFont systemFontOfSize:15];
    [_leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
    
    _rightLable = [UILabel new];
    [self.contentView addSubview:_rightLable];
    _rightLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _rightLable.font = [UIFont systemFontOfSize:15];
    [_rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLable.mas_right).offset(50);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.textField = [UITextField new];
    self.textField.hidden = true;
    [self.contentView addSubview:self.textField ];
    self.textField .textColor = [UIColor colorWithHexString:@"#cccccc"];
    self.textField .font = [UIFont systemFontOfSize:15];
    [self.textField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLable.mas_right).offset(50);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
