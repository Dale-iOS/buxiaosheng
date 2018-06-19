//
//  AssignDeliveryCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AssignDeliveryCell.h"
#import "LZAssignDeliveryModel.h"

@implementation AssignDeliveryCell
@synthesize selectIM,whithBgView,iconIM,iconName,timeLbl,subLbl,demandLbl,titleLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        [self autoLayout];
        
    }
    return self;
}

#pragma mark ---- lazy loading ----
- (UIImageView *)selectIM
{
    if (selectIM == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"noSelect");
        [self.contentView addSubview:(selectIM = imageView)];
    }
    return selectIM;
}

- (UIView *)whithBgView
{
    if (whithBgView == nil) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 8.0f;
        [self.contentView addSubview:(whithBgView = view)];
    }
    return whithBgView;
}

- (UIImageView *)iconIM
{
    if (iconIM == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self.whithBgView addSubview:(iconIM = imageView)];
    }
    return iconIM;
}

- (UILabel *)iconName
{
    if (iconName == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(13);
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        label.textAlignment = NSTextAlignmentCenter;
        [self.whithBgView addSubview:(iconName = label)];
    }
    return iconName;
}

- (UILabel *)titleLbl
{
    if (titleLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self.whithBgView addSubview:(titleLbl = label)];
    }
    return titleLbl;
}

- (UILabel *)subLbl
{
    if (subLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.whithBgView addSubview:(subLbl = label)];
    }
    return subLbl;
}

- (UILabel *)demandLbl
{
    if (demandLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.whithBgView addSubview:(demandLbl = label)];
    }
    return demandLbl;
}

- (UILabel *)timeLbl
{
    if (timeLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.whithBgView addSubview:(timeLbl = label)];
    }
    return timeLbl;
}

- (void)autoLayout
{
    [self.selectIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_offset(19);
        make.height.mas_offset(19);
    }];
    
    [self.whithBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.iconIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(40);
        make.left.equalTo(self.whithBgView).offset(15);
        make.centerY.equalTo(self.whithBgView);
    }];
    
    [self.iconName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconIM);
        make.height.mas_offset(14);
        make.centerX.equalTo(iconIM);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whithBgView).offset(70);
        make.top.equalTo(self.whithBgView.mas_top).offset(20);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    [self.subLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whithBgView).offset(70);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(10);
        make.width.mas_offset(250);
        make.height.mas_offset(13);
    }];
    
    [self.demandLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whithBgView).offset(70);
        make.top.equalTo(self.subLbl.mas_bottom).offset(10);
        make.width.mas_offset(250);
        make.height.mas_offset(13);
    }];
    
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whithBgView).offset(70);
        make.top.equalTo(self.demandLbl.mas_bottom).offset(10);
        make.width.mas_offset(250);
        make.height.mas_offset(13);
    }];
}

- (void)setModel:(LZAssignDeliveryModel *)model
{
    _model = model;
    self.titleLbl.text = [NSString stringWithFormat:@"客户：%@",_model.customerName];
    
    if (_model.drawerName.length >2) {
        self.iconName.text = [_model.drawerName substringFromIndex:2];
    }else
    {
        self.iconName.text = _model.drawerName;
    }
    
    self.subLbl.text = _model.productName;
    self.demandLbl.text = [NSString stringWithFormat:@"需求量：%@       出库数：%@",_model.needTotal,_model.number];
    self.timeLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    
    if (_model) {
        <#statements#>
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

