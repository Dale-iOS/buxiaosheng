//
//  LLAuditMangerCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAuditMangerCell.h"
#import "LLAuditMangerModel.h"
@implementation LLAuditMangerCell
{
    UIImageView * _iconImageView;
    UILabel * _nameLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(LLAuditMangerItemModel *)model {
    _model = model;
    _nameLable.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"auditManger_icon"]];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.centerY.equalTo(self.contentView);
    }];
    
    _nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.font = [UIFont systemFontOfSize:15];
    _nameLable.textColor = [UIColor darkGrayColor];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
