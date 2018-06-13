//
//  LZMarketCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZMarketCell.h"
#import "LZMarketModel.h"

@implementation LZMarketCell
@synthesize bgView,iconImageView,iconNameLabel,titleLabel,stateLabel,subLabel,priceLabel,lineView,timeLabel,yesBtn,noBtn,NumLabel;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        
        [self setSDlayout];
        
    }
    return self;
}

#pragma mark ------- lazy loding --------
- (UIView *)bgView
{
    if (bgView == nil)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        [contentView addSubview:(bgView = view)];
    }
    return bgView;
}

- (UIImageView *)iconImageView
{
    if (iconImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self.bgView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)iconNameLabel
{
    if (iconNameLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor whiteColor];
        [self.iconImageView addSubview:(iconNameLabel = label)];
    }
    return iconNameLabel;
}


- (UILabel *)titleLabel
{
    if (titleLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self.bgView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)subLabel
{
    if (subLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(subLabel = label)];
    }
    return subLabel;
}

- (UILabel *)priceLabel
{
    if (priceLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(priceLabel = label)];
    }
    return priceLabel;
}

- (UILabel *)stateLabel
{
    if (stateLabel == nil) {
        
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithHexString:@"#ff6565"];
        label.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f];
        label.layer.cornerRadius = 2.0f;
        label.font = FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"销售需求发起的审批";
        label.layer.masksToBounds = YES;
        [self.bgView addSubview:(stateLabel = label)];
    }
    return stateLabel;
}

- (UILabel *)NumLabel
{
    if (NumLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"需求量：36863";
        label.hidden = YES;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(NumLabel = label)];
    }
    return NumLabel;
}

- (UIView *)lineView
{
    if (lineView == nil)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(lineView = view)];
    }
    return lineView;
}

- (UILabel *)timeLabel
{
    if (timeLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text99;
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (UIButton *)yesBtn
{
    if (yesBtn == nil)
    {
        UIButton *btn = [UIButton new];
        btn.layer.cornerRadius = 5.0f;
        btn.layer.borderColor = [[UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = FONT(13);
        [btn setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f]];
        [btn setTitle:@"同意" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(yesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:(yesBtn = btn)];
    }
    return yesBtn;
}

- (UIButton *)noBtn
{
    if (noBtn == nil)
    {
        UIButton *btn = [UIButton new];
        btn.layer.cornerRadius = 5.0f;
        btn.layer.borderColor = [[UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = FONT(13);
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:@"拒绝" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(noBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:(noBtn = btn)];
    }
    return noBtn;
}

//自动布局
- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 8)
    .widthIs(APPWidth -16)
    .heightIs(140);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 28)
    .widthIs(40)
    .heightIs(40);
    
    self.iconNameLabel.sd_layout
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView)
    .widthIs(40)
    .heightIs(14);
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.bgView, 20)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(200)
    .heightIs(15);
    
    self.subLabel.sd_layout
    .topSpaceToView(self.titleLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
    self.priceLabel.sd_layout
    .topSpaceToView(self.subLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
    self.stateLabel.sd_layout
    .topEqualToView(self.titleLabel)
    .rightSpaceToView(self.bgView, 15)
    .heightIs(20)
    .widthIs(120);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.bgView, 0)
    .bottomSpaceToView(self.bgView, 44)
    .widthIs(APPWidth)
    .heightIs(1);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .bottomSpaceToView(self.bgView, 17)
    .widthIs(150)
    .heightIs(13);
    
    self.yesBtn.sd_layout
    .rightSpaceToView(self.bgView, 15)
    .bottomSpaceToView(self.bgView, 7)
    .widthIs(64)
    .heightIs(29);
    
    self.noBtn.sd_layout
    .rightSpaceToView(self.yesBtn, 15)
    .bottomSpaceToView(self.bgView, 7)
    .widthIs(64)
    .heightIs(29);
    
    self.NumLabel.sd_layout
    .leftSpaceToView(self.bgView, 70)
    .topSpaceToView(self.priceLabel, 10)
    .widthIs(250)
    .heightIs(13);
}

- (void)setModel:(LZMarketModel *)model{
    _model = model;
    if (_model.initiatorName.length >3) {
        self.iconNameLabel.text = [_model.initiatorName substringFromIndex:3];
    }else{
        self.iconNameLabel.text = _model.initiatorName;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@的审批",_model.initiatorName];
    self.subLabel.text = [NSString stringWithFormat:@"品名：%@",_model.productName];
    self.priceLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.number];
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
}

- (void)yesBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickYesBtnInCell:)]) {
        [self.delegate didClickYesBtnInCell:self];
    }
}

- (void)noBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickNoBtnInCell:)]) {
        [self.delegate didClickNoBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
