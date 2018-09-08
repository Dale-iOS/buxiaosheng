//
//  BXSStockProductCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 请输入产品名称--请选择颜色--请输入数量

#import "BXSStockProductCell.h"
#import "ComView.h"
@interface BXSStockProductCell ()<UITextFieldDelegate>
@end
@implementation BXSStockProductCell
//{
//    UITextField *_nameTF;
//    UITextField *_colorTF;
//    UITextField *_needCountTF;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setup {
    
    CGFloat kWidth = APPWidth/3;
    //_nameTF
    _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 5, kWidth, 40)];
    _nameTF.textAlignment = NSTextAlignmentCenter;
    _nameTF.placeholder = @"请输入产品名称";
    _nameTF.font = FONT(14);
    _nameTF.delegate = self;
    [self.contentView addSubview:_nameTF];
    
    //_colorTF
    _colorTF = [[UITextField alloc]initWithFrame:CGRectMake(_nameTF.right, 5, kWidth, 40)];
    _colorTF.textAlignment = NSTextAlignmentCenter;
    _colorTF.placeholder = @"请选择颜色";
    _colorTF.font = FONT(14);
    [self.contentView addSubview:_colorTF];
    
    //cover
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(clickCover) forControlEvents:UIControlEventTouchUpInside];
    button.frame = _colorTF.frame;
    [self.contentView addSubview:button];
    
    //_needCountTF
    _needCountTF = [[UITextField alloc]initWithFrame:CGRectMake(_colorTF.right, 5, kWidth, 40)];
    _needCountTF.textAlignment = NSTextAlignmentCenter;
    _needCountTF.placeholder = @"请输入数量";
    _needCountTF.font = FONT(14);
    _needCountTF.delegate = self;
    [self.contentView addSubview:_needCountTF];
}

//MARK: ---Click--
- (void)clickCover {
    if (_nameTF.text.length == 0 || _model.productId == nil) {
        [LLHudTools showWithMessage:@"请先输入产品名称"];
        return;
    }
    !_clickSelectColorBlock?:_clickSelectColorBlock();
}

-(void)setModel:(LZPurchaseModel *)model {
    _model = model;
    _nameTF.text = model.productName;
    _needCountTF.text = model.totalNumber;
 
}

//MARK: -- UITextFieldDelegate ---
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == _nameTF) {
        _model.productName = textField.text;
    }
    if (textField == _needCountTF) {
         _model.totalNumber = textField.text;
        if (_clickNeedGetBottomDataBlock) {
            _clickNeedGetBottomDataBlock();
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _nameTF) {
        _nameTF.text = textField.text;
        if ([self.delegate respondsToSelector:@selector(clickEditorProductName:andCell:)]) {
            [self.delegate clickEditorProductName:_nameTF andCell:self];
        }
    }
    return YES;
}


@end
