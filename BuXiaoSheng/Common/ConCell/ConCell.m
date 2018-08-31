//
//  ConCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ConCell.h"
#import "UITextView+Placeholder.h"

@interface ConCell ()<UITextFieldDelegate>

@end

@implementation ConCell
{
    UILabel *_leftLable;
    UITextField *_midTF;
    UIButton *_rightButton;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setup {
    
    self.selectionStyle = 0;
    _leftLable = [UILabel new];
    [self.contentView addSubview:_leftLable];
    _leftLable.textColor = CD_Text33;
    _leftLable.font = [UIFont systemFontOfSize:15];
    
    [_leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_offset(120);
    }];
    
    _midTF = [UITextField new];
    [self.contentView addSubview:_midTF ];
    _midTF .textColor = CD_Text33;
    _midTF .font = [UIFont systemFontOfSize:15];
    [_midTF  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLable.mas_right).offset(5);
        make.centerY.equalTo(self.contentView);
        make.bottom.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-40);
    }];
    _midTF.delegate = self;
    
    _rightButton = [UIButton new];
    [_rightButton addTarget:self action:@selector(clickCell) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setImage:IMAGE(@"auditManger_arrow") forState:0];
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(25);
    }];
}

- (void)clickCell {
    
    !_clickCellBlock?:_clickCellBlock();
}
-(void)setK_titlewWidth:(CGFloat)k_titlewWidth {
    [_leftLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(k_titlewWidth);
    }];
}

-(void)setItem:(ConItem *)item {
    _item = item;
    _leftLable.text = item.title;
    _midTF.text = item.kpText;
    _midTF.placeholder = item.kpText;
    _midTF.text = item.contenText;
    _midTF.textColor =  item.textColor?item.textColor:[UIColor blackColor];
    _midTF.enabled = item.conType == ConTypeB;;
    _rightButton.hidden = !(item.conType == ConTypeA);
    _leftLable.textColor  = item.titleColor?item.titleColor:[UIColor blackColor];
    if ([item.title containsString:@"*"]) {
        [_leftLable setupAttributeString:item.title changeText:@"*" color:[UIColor redColor]];
    }
    
    [self setNeedsDisplay];
    
}

#pragma mark --- UITextViewDelegate ---

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _item.contenText = textField.text;
    !_endEdtingBlock?:_endEdtingBlock(_item);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    _item.contenText = textField.text;
    if ([self.item.delegate respondsToSelector:@selector(didClickItemInTextField:)]) {
        [_item.delegate didClickItemInTextField:_midTF];
    }
    return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    _item.contenText = textField.text;
//    if ([self.item.delegate respondsToSelector:@selector(didClickItemInTextField:)]) {
//        [_item.delegate didClickItemInTextField:_midTF];
//    }
//}

@end


@implementation ConMarkCell
{
    UITextView *_tv;
}
-(void)setup {
    
    [super setup];
    //更换tf-->tv
    UITextField *tf = [self valueForKey:@"_midTF"];
    [tf removeFromSuperview];
    
    _tv = [UITextView new];
    [self.contentView addSubview:_tv];
    _tv .textColor = CD_Text33;
    _tv .font = [UIFont systemFontOfSize:15];
    
    UILabel *leftlabel = [self valueForKey:@"_leftLable"];
    [leftlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        //make.bottom.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.contentView).offset(13);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_offset(120);
    }];
    
    
    [_tv  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftlabel.mas_right).offset(5);
        make.centerY.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-40);
    }];
    _tv.delegate = self;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.item.contenText = textView.text;
    !self.endEdtingBlock?:self.endEdtingBlock(self.item);
}


-(void)setItem:(ConItem *)item {
    
    [super setItem:item];
    
    _tv.text = item.kpText;
    _tv.placeholder = item.kpText;
    _tv.text = item.contenText;
    _tv.textColor =  item.textColor?item.textColor:[UIColor blackColor];
    _tv.userInteractionEnabled = item.conType == ConTypeB;;
    
    [self setNeedsDisplay];
    
}
@end

@implementation ConItem
-(instancetype)initWithTitle:(NSString *)title kpText:(NSString *)kpText conType:(ConType)conType {
    
    if (self = [super init]) {
        
        _title = title;
        _kpText = kpText;
        _conType = conType;
    }
    return self;
}
@end


