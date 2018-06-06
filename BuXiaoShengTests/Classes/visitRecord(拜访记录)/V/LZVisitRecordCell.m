//
//  LZVisitRecordCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZVisitRecordCell.h"
#import "LZVisitModel.h"

@implementation LZVisitRecordCell
@synthesize bgView,iconImageView,iconLabel,typeLabel,nameLabel,matterLabel,timeLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        [self setNeedsUpdateConstraints];
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
        [self.contentView addSubview:(bgView = view)];
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

- (UILabel *)iconLabel
{
    if (iconLabel == nil)
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

- (UILabel *)nameLabel
{
    if ( nameLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self.bgView addSubview:(nameLabel = label)];
    }
    return nameLabel;
}

- (UILabel *)typeLabel
{
    if (typeLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(typeLabel = label)];
    }
    return typeLabel;
}

- (UILabel *)matterLabel
{
    if (matterLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(matterLabel = label)];
    }
    return matterLabel;
}

- (UILabel *)timeLabel
{
    if (timeLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(122);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.centerY.equalTo(self.bgView);
        make.width.and.height.mas_offset(40);
    }];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(self.iconImageView);
        make.height.mas_offset(14);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(15);
        make.left.equalTo(self.iconImageView).offset(70);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView).offset(70);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    [self.matterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView).offset(70);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.matterLabel.mas_bottom).offset(10);
        make.left.equalTo(self.iconImageView).offset(70);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
}

- (void)setModel:(LZVisitModel *)model
{
    _model = model;
    
    if (_model.memberName.length >3) {
        self.iconLabel.text = [_model.memberName substringFromIndex:3];
    }else{
        self.iconLabel.text = _model.memberName;
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"拜访对象：%@",_model.name];
    
//    拜访方式（0：当面拜访 1：电话拜访 2:聊天软件拜访 3：其他）
    switch ([_model.type integerValue]) {
        case 0:
            self.typeLabel.text = @"当面拜访";
            break;
        case 1:
            self.typeLabel.text = @"电话拜访";
            break;
        case 2:
            self.typeLabel.text = @"聊天软件拜访";
            break;
        case 3:
            self.typeLabel.text = @"其他拜访方式";
            break;
        default:
            break;
    }
    
    self.matterLabel.text = _model.matters;
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
