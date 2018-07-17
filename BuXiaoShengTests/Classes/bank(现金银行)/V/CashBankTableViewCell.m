//
//  CashBankTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "CashBankTableViewCell.h"
#import "LLCashBankModel.h"
@implementation CashBankTableViewCell
@synthesize bgView,iconImageView,titleLabel,rightArrowImageVIew;
#define contentView   self.contentView


-(void)setModel:(LLCashBankModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.row <3) {
        rightArrowImageVIew.hidden = YES;
    }
}

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
//        //        阴影的颜色
//        view.layer.shadowColor = [UIColor blackColor].CGColor;
//        //        阴影的透明度
//        view.layer.shadowOpacity = 0.6f;
//        //        阴影的偏移量
//        view.layer.shadowOffset = CGSizeMake(4,4);
        [contentView addSubview:(bgView = view)];
    }
    return bgView;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"icbc");
        [self.bgView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel
{
    if (!titleLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"中国工商银行";
        label.font = FONT(14);
        label.textColor = [UIColor colorWithR:51.0f/255.0f G:51.0f/255.0f B:51.0f/255.0f A:1.0f];
        [self.bgView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UIImageView *)rightArrowImageVIew
{
    if (!rightArrowImageVIew) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.hidden = YES;
        imageView.image = IMAGE(@"rightarrow");
        [self.bgView addSubview:(rightArrowImageVIew = imageView)];
    }
    return rightArrowImageVIew;
}

- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 8)
    .widthIs(APPWidth -16)
    .heightIs(75);
    
//    self.iconImageView.sd_layout
//    .leftSpaceToView(self.bgView, 15)
//    .centerYEqualToView(self.bgView)
//    .widthIs(40)
//    .heightIs(40);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .widthIs(250)
    .heightIs(15)
    .centerYEqualToView(self.bgView);
    
    self.rightArrowImageVIew.sd_layout
    .rightSpaceToView(self.bgView, 15)
    .widthIs(8)
    .heightIs(14)
    .centerYEqualToView(self.bgView);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
