//
//  DidOutInventoryCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  已出库cell

#import "DidOutInventoryCell.h"
#import "LZOrderTrackingModel.h"

@implementation DidOutInventoryCell
@synthesize bgView,iconImageView,companyLabel,nameLabel,demandLabel,OutNumLabel,priceLabel,timeLabel,transportLabel,didTransportLabel,receivingLabel,iconLabel,redLeftView,receivingBtn;
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
    if (!bgView)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        //        阴影的颜色
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        //        阴影的透明度
        view.layer.shadowOpacity = 0.6f;
        //        阴影的偏移量
        view.layer.shadowOffset = CGSizeMake(4,4);
        [contentView addSubview:(bgView = view)];
    }
    return bgView;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self.bgView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)companyLabel
{
    if (!companyLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"companyLabel";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithR:51.0f/255.0f G:51.0f/255.0f B:51.0f/255.0f A:1.0f];
        [self.bgView addSubview:(companyLabel = label)];
    }
    return companyLabel;
}

- (UILabel *)nameLabel
{
    if (!nameLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"nameLabel";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(nameLabel = label)];
    }
    return nameLabel;
}

- (UILabel *)demandLabel
{
    if (!demandLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"demandlabel ";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(demandLabel = label)];
    }
    return demandLabel;
}

- (UILabel *)OutNumLabel
{
    if (!OutNumLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @" outnumLabel";
        label.textColor = [UIColor colorWithHexString:@"#ff6565"];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);

        [self.bgView addSubview:(OutNumLabel = label)];
    }
    return OutNumLabel;
}

- (UILabel *)priceLabel
{
    if (!priceLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"priceLabel";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(priceLabel = label)];
    }
    return priceLabel;
}

- (UILabel *)timeLabel
{
    if (!timeLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @" timeLabel";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (UILabel *)transportLabel
{
    if (!transportLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"已出库运输中";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithHexString:@"#23c4dc"];
        label.backgroundColor = [UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:0.3f];
        label.layer.cornerRadius = 2.0f;
        label.layer.masksToBounds = YES;
        label.hidden = YES;
        [self.bgView addSubview:(transportLabel = label)];
    }
    return transportLabel;
}

- (UILabel *)didTransportLabel
{
    if (!didTransportLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"已出库待送货";
        label.textColor = [UIColor colorWithHexString:@"#ff6565"];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.3f];
        label.layer.cornerRadius = 2.0f;
        label.layer.masksToBounds = YES;
        label.font = FONT(12);
        label.hidden = YES;
        [self.bgView addSubview:(didTransportLabel = label)];
    }
    return didTransportLabel;
}

- (UILabel *)receivingLabel
{
    if (!receivingLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"收货";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
        label.layer.cornerRadius = 5.0f;
        label.layer.masksToBounds = YES;
        label.hidden = YES;
        label.layer.masksToBounds = YES;
        [self.bgView addSubview:(receivingLabel = label)];
    }
    return receivingLabel;
}

- (UIButton *)receivingBtn{
    if (!receivingBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"收货" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(13);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        btn.hidden = YES;
        [btn addTarget:self action:@selector(receivingBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:(receivingBtn = btn)];
    }
    return receivingBtn;
}

- (UILabel *)iconLabel
{
    if (!iconLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        label.backgroundColor =[UIColor clearColor];
        [self.iconImageView addSubview:(iconLabel = label)];
    }
    return iconLabel;
}

- (UIView *)redLeftView
{
    if (!redLeftView) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexString:@"#ff6565"];
        [self.bgView addSubview:(redLeftView = view)];
    }
    return redLeftView;
}

//自动布局
- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 8)
    .widthIs(APPWidth -16)
    .heightIs(133);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 35)
    .widthIs(40)
    .heightIs(40);
    
    
    self.companyLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.bgView, 10)
    .heightIs(15);
    [self.companyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.companyLabel, 10)
    .heightIs(13);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.demandLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.demandLabel setSingleLineAutoResizeWithMaxWidth:100];

    self.OutNumLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.demandLabel, 10)
    .heightIs(13);
    [self.OutNumLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.priceLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 135)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:100];

    self.timeLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.OutNumLabel, 10)
    .heightIs(13);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.iconLabel.sd_layout
    .widthIs(40)
    .heightIs(14)
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView);
    
    self.receivingLabel.sd_layout
    .widthIs(64)
    .heightIs(29)
    .rightSpaceToView(self.bgView, 15)
    .bottomSpaceToView(self.bgView, 15);
    
    self.receivingBtn.sd_layout
    .widthIs(64)
    .heightIs(29)
    .rightSpaceToView(self.bgView, 15)
    .bottomSpaceToView(self.bgView, 15);
    
    
    
    self.transportLabel.sd_layout
    .widthIs(80)
    .heightIs(20)
    .rightSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 15);
    
    
    self.didTransportLabel.sd_layout
    .widthIs(80)
    .heightIs(20)
    .rightSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 15);
    
    self.redLeftView.sd_layout
    .topSpaceToView(self.bgView, 0)
    .bottomSpaceToView(self.bgView, 0)
    .leftSpaceToView(self.bgView, 0)
    .widthIs(7);
    //设置多出superView的部分隐藏
    self.bgView.clipsToBounds = YES;
}

- (void)setModel:(LZOrderTrackingModel *)model{
    
    _model = model;
    if (_model.drawerName.length >3 && _model.drawerName.length >0) {
        self.iconLabel.text = [_model.drawerName substringFromIndex:3];
    }else
    {
        self.iconLabel.text = _model.drawerName;
    }
    self.companyLabel.text = _model.customerName;
    self.nameLabel.text = _model.productName;
    self.demandLabel.text = [NSString stringWithFormat:@"需求量：%@",_model.needTotal];
    self.priceLabel.text = [NSString stringWithFormat:@"￥：%@",_model.price];
   
    
    NSString *temgpStr = [NSString stringWithFormat:@"%zd",[_model.needTotal integerValue]-[_model.number integerValue]];
    self.OutNumLabel.text = [NSString stringWithFormat:@"出库量：%@ -%@",_model.number,temgpStr ];
    NSMutableAttributedString *OutNumStr = [[NSMutableAttributedString alloc] initWithString:self.OutNumLabel.text];
     NSRange oneRange = [[OutNumStr string] rangeOfString:[NSString stringWithFormat:@"出库量："]];
    [OutNumStr addAttribute:NSForegroundColorAttributeName value:CD_Text66 range:oneRange];
    self.OutNumLabel.attributedText = OutNumStr;
    
    
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];

    
    if ([_model.orderStatus integerValue] == 1) {
        self.didTransportLabel.hidden = NO;
        self.receivingLabel.hidden = YES;
        self.transportLabel.hidden = YES;
        self.redLeftView.hidden = NO;
    }else if ([_model.orderStatus integerValue] == 2)
    {
        self.didTransportLabel.hidden = YES;
        [self.receivingBtn setHidden:NO];
//        self.receivingLabel.hidden = NO;
        self.transportLabel.hidden = NO;
        self.redLeftView.hidden = YES;
    }
}

//收货按钮代理
- (void)receivingBtnClick{
    if ([self.delegate respondsToSelector:@selector(didClickreceivingBtnInCell:)]) {
        [self.delegate didClickreceivingBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
