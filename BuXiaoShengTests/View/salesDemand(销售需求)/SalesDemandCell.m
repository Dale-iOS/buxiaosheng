//
//  SalesDemandCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SalesDemandCell.h"


@interface SalesDemandCell()<UITextFieldDelegate>
@property (nonatomic, strong)salesDemandModel *model;
@end;

@implementation SalesDemandCell
{
    void (^_block)(salesDemandModel *infoModel);
}
@synthesize titleBtn,colorTF,lineTF,numberTF,priceTF;
#define contentView  self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.model = [[salesDemandModel alloc]init];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleTFChanging:) name:UITextFieldTextDidChangeNotification object:self.titleTF];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorTFChanging:) name:UITextFieldTextDidChangeNotification object:self.colorTF];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lineTFChanging:) name:UITextFieldTextDidChangeNotification object:self.lineTF];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberTFChanging:) name:UITextFieldTextDidChangeNotification object:self.numberTF];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceTFChanging:) name:UITextFieldTextDidChangeNotification object:self.priceTF];
        
        [self setupAutoLayout];
    }
    return self;
}

#pragma mark ------ lazy loding ------
//- (UITextField *)titleTF
//{
//    if (!titleTF) {
//        UITextField *tf = [[UITextField alloc]init];
//        tf.font = FONT(14);
//        tf.textColor = CD_Text33;
//        tf.placeholder = @"品名";
//        tf.delegate = self;
////        tf.enabled = NO;
//        tf.userInteractionEnabled = YES;
//        tf.textAlignment = NSTextAlignmentCenter;
////        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(titleTFClick)];
////        [tf addGestureRecognizer:tap];
//        [contentView addSubview:(titleTF = tf)];
//    }
//    return titleTF;
//}
- (UIButton *)titleBtn
{
    if (!titleBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"品名" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(14);
        [btn setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:(titleBtn = btn)];
    }
    return titleBtn;
}

- (UITextField *)colorTF
{
    if (!colorTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"颜色";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(colorTF = tf)];
    }
    return colorTF;
}

- (UITextField *)lineTF
{
    if (!lineTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"条数";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(lineTF = tf)];
    }
    return lineTF;
}

- (UITextField *)numberTF
{
    if (!numberTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"数量";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(numberTF = tf)];
    }
    return numberTF;
}

- (UITextField *)priceTF
{
    if (!priceTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"单价";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(priceTF = tf)];
    }
    return priceTF;
}

- (void)setupAutoLayout
{
//    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(contentView).offset(0);
//        make.centerY.equalTo(contentView);
//        make.width.offset(LZHScale_WIDTH(240));
//        make.height.offset(65);
//    }];
    
    self.titleBtn.sd_layout
    .leftSpaceToView(contentView, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(240))
    .heightIs(65);
    
    self.colorTF.sd_layout
    .leftSpaceToView(self.titleBtn, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.lineTF.sd_layout
    .leftSpaceToView(self.colorTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);
    
    self.numberTF.sd_layout
    .leftSpaceToView(self.lineTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.priceTF.sd_layout
    .leftSpaceToView(self.numberTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);

}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if ([textField isEqual:self.titleTF]) {
////        self.titleTF.text = @"请选择";
////        self.titleTF.textColor = [UIColor blueColor];
////        NSLog(@"%f+++++%f",self.titleTF.centerY);
////        NSLog(@"+++++++-----%f",self.titleTF.frame.or);
//        
//        
//        if ([self.delegate respondsToSelector:@selector(didClickTitleTextField:)]) {
//            [self.delegate didClickTitleTextField:self.titleTF.text];
//        }
//    }
//}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([textField isEqual:self.titleTF]) {
//        self.model.titleInfo = self.titleTF.text;
////        self.titleTF.textColor = [UIColor whiteColor];
//    }
    if ([textField isEqual:self.colorTF]) {
        self.model.colorInfo = self.colorTF.text;
    }
    if ([textField isEqual:self.lineTF]) {
        self.model.lineInfo = self.lineTF.text;
    }
    if ([textField isEqual:self.numberTF]) {
        self.model.numberInfo = self.numberTF.text;
    }
    if ([textField isEqual:self.priceTF]) {
        self.model.priceInfo = self.priceTF.text;
    }
}

- (void)titleTFChanging:(id)sender
{
    if (_block) {
        _block(self.model);
    }
}

- (void)colorTFChanging:(id)sender
{
    if (_block) {
        _block(self.model);
    }
}


- (void)lineTFChanging:(id)sender
{
    if (_block) {
        _block(self.model);
    }
}


- (void)numberTFChanging:(id)sender
{
    if (_block) {
        _block(self.model);
    }
}


- (void)priceTFChanging:(id)sender
{
    if (_block) {
        _block(self.model);
    }
}

-(void)settitleTFContent:(NSString *)title WithColorTFContent:(NSString *)color WithlineTFContent:(NSString *)line WithNumberTFContent:(NSString *)number WithPriceTFContent:(NSString *)price WithReturnBlock:(void (^)(salesDemandModel *model))textFieldBlock
{

//    self.titleTF.text = title;
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    self.colorTF.text = color;
    self.lineTF.text = line;
    self.numberTF.text = number;
    self.priceTF.text = price;
    _block = textFieldBlock;
}

//点击事件
- (void)titleBtnClick
{
//    if ([self.delegate respondsToSelector:@selector(didClickTitleTextField:)]) {
//        [self.delegate didClickTitleTextField:self.titleTF.text];
//    }
    if ([self.delegate respondsToSelector:@selector(didClickTitleBtn:)]) {
        [self.delegate didClickTitleBtn:self.titleBtn];
    }
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
