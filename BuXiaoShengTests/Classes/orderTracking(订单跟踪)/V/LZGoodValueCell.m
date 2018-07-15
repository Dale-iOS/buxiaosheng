//
//  LZGoodValueCell.m
//  BuXiaoSheng
//
//  Created by ap on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZGoodValueCell.h"

@interface LZGoodValueCell()<UITextFieldDelegate>

@end

@implementation LZGoodValueCell
{
    __weak IBOutlet UILabel *goodNameLB;
    
    __weak IBOutlet UILabel *colorLb;
    
    __weak IBOutlet UILabel *pageLb;
    
    __weak IBOutlet UILabel *numberLB;
    
    __weak IBOutlet UIButton *numberBtn;
    __weak IBOutlet UILabel *unitLB;
    
    __weak IBOutlet UITextField *priceTf;
    
    __weak IBOutlet UIView *lineView;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    priceTf.delegate = self;
    lineView.backgroundColor = LZHBackgroundColor;
 
}

- (void)setModel:(BatchNumberList *)model
{
    _model = model;
    goodNameLB.text = _model.productName;
    colorLb.text = _model.productColorName;
    pageLb.text = _model.total;
    numberLB.text = _model.number;
    unitLB.text = _model.unitName;
    priceTf.text = _model.price;

}


- (IBAction)didClicknumberAction:(UIButton *)sender {
    
    if (_didClickCompltBlock) {
        _didClickCompltBlock();
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.price = textField.text;
}


@end
