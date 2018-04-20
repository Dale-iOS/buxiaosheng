//
//  DemandListTableViewCell.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "DemandListTableViewCell.h"

@implementation DemandListTableViewCell
@synthesize nameTF,colorTF,lineNumTF,numTF,priceTF;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        [self setSD_layout];
    }
    return self;
}

#pragma mark ---------- lazy loding -----------
- (UITextField *)nameTF
{
    if (!nameTF) {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = CD_Text33;
        textField.placeholder = @"品名";
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:(nameTF = textField)];
    }
    return nameTF;
}

- (UITextField *)colorTF
{
    if (!colorTF) {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = CD_Text33;
        textField.placeholder = @"颜色";
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:(colorTF = textField)];
    }
    return colorTF;
}

- (UITextField *)lineNumTF
{
    if (!lineNumTF) {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = CD_Text33;
        textField.placeholder = @"条数";
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:(lineNumTF = textField)];
    }
    return lineNumTF;
}

- (UITextField *)numTF
{
    if (!numTF) {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = CD_Text33;
        textField.placeholder = @"数量";
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:(numTF = textField)];
    }
    return numTF;
}

- (UITextField *)priceTF
{
    if (!priceTF) {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = CD_Text33;
        textField.placeholder = @"单价";
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:(priceTF = textField)];
    }
    return priceTF;
}

- (void)setSD_layout
{
    self.nameTF.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(LZHScale_WIDTH(240));
    
    self.colorTF.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(self.nameTF, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    self.lineNumTF.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(self.colorTF, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    self.numTF.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(self.lineNumTF, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    self.priceTF.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(self.numTF, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(LZHScale_WIDTH(105));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
