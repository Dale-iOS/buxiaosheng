//
//  LZFineCodeCell.m
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZFineCodeCell.h"

@implementation LZFineCodeCell
{
    
    UILabel *_leftLable;
    UITextField *_rightTF;
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
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _leftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 48)];
    [self.contentView addSubview:_leftLable];
    _leftLable.font = FONT(15);
    _leftLable.textColor =  [UIColor blackColor];
    
    _rightTF = [[UITextField alloc]initWithFrame:CGRectMake(_leftLable.right+5, 0, SCREEN_WIDTH - _leftLable.right-20, _leftLable.height)];
    [self.contentView addSubview:_rightTF];
    _rightTF.textColor = [UIColor blackColor];
    _rightTF.font = FONT(15);
    _rightTF.rightViewMode = UITextFieldViewModeWhileEditing;
    _rightTF.placeholder = @"请输入细码数";
    _rightTF.delegate = self;
    _rightTF.keyboardType = UIKeyboardTypePhonePad;
    
}


-(void)setModel:(LZFindCodeModel *)model {
    
    _model = model;
    _leftLable.text = model.title;
    _rightTF.text = model.code;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _model.code = _rightTF.text;
    
}


@end
