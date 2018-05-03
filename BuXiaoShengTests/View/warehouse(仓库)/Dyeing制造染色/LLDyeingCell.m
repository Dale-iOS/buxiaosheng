//
//  LLDyeingCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLDyeingCell.h"

@implementation LLDyeingCell
{
    UILabel * _leftLable;
    UILabel * _rightLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    _leftLable.text = [self.datas[indexPath.row-1] objectForKey:@"key"];
     self.accessoryType = UITableViewCellAccessoryNone;
    if ([self.datas[indexPath.row-1][@"value"]isEqualToString:@""]) {
        self.textField.hidden = false;
        _rightLable.hidden = true;
        switch (indexPath.row-1) {
            case 0:
                self.textField.placeholder = @"请选择结算单位";
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 1:
                self.textField.placeholder = @"请输入批号";
                break;
            case 2:
                self.textField.placeholder = @"请输入货架号";
                break;
            default:
                break;
        }
    }else {
        self.textField.hidden = true;
        _rightLable.hidden = false;
        _rightLable.text = self.datas[indexPath.row-1][@"value"];
        if ([self.datas[indexPath.row-1][@"type"]isEqualToString:@"1"]) {
            _rightLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
        }else if ([self.datas[indexPath.row-1][@"type"]isEqualToString:@"2"]){
             _rightLable.textColor = [UIColor redColor];
        }else if ([self.datas[indexPath.row-1][@"type"]isEqualToString:@"0"]) {
             _rightLable.textColor = [UIColor colorWithHexString:@"#333333"];
        }
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

@end
