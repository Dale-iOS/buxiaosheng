//
//  AddColorCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AddColorCell.h"

@interface AddColorCell()<UITextFieldDelegate>
@end;

@implementation AddColorCell
{
    void (^_block)(NSString *contentTFInfo);
}
@synthesize titleLbl,contentTF;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidEndEditingNotification object:self.contentTF];
        
        [self setSDautoLayout];
    }
    return self;
}

#pragma mark ------- lazy longding -------
- (UILabel *)titleLbl
{
    if (titleLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text33;
        label.font = FONT(14);
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(titleLbl = label)];
    }
    return titleLbl;
}

- (UITextField *)contentTF
{
    if (contentTF == nil) {
        UITextField *tf = [[UITextField alloc]init];
        tf.placeholder = @"请输入颜色";
        tf.textColor = CD_Text33;
        tf.font = FONT(14);
        tf.delegate = self;
        [contentView addSubview:(contentTF = tf)];
    }
    return contentTF;
}

//开始自动布局
- (void)setSDautoLayout
{
    self.titleLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .centerYEqualToView(contentView)
    .widthIs(100)
    .heightIs(15);
    
    self.contentTF.sd_layout
    .leftSpaceToView(contentView, 120)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth -120 -15)
    .heightIs(15);
}

-(void)textFieldChanging:(id)sender{
    if (_block) {
        _block(self.contentTF.text);
    }
}

//-(void)setCellInfo:(NSString*)title withInputDesc:(NSString*)desc withKeybordType:(NSInteger)type withText:(NSString *)text WithReturnBlock:(void (^)(NSString *))textFieldBlock{
//    if (type==1) {
//        self.contentTF.keyboardType = UIKeyboardTypeNumberPad;
//    }
//    self.contentTF.text =text;
//    self.contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _block = textFieldBlock;
//    self.titleLbl.text = title;
//    self.contentTF.placeholder = desc;
//}

-(void)setCellTitle:(NSString*)title WithReturnBlock:(void (^)(NSString *result))textFieldBlock
{
    self.titleLbl.text = title;
    _block = textFieldBlock;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
