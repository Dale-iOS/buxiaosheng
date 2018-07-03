//
//  LLOutbounceSeletedLeftCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/1.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLOutbounceSeletedLeftCell.h"

@implementation LLOutbounceSeletedLeftCell
{
    UIView * _seletedView;
    
    UILabel * _outbounceName;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LLOutboundlistModel *)model {
    _model = model;
    
    _seletedView.hidden = !model.seleted;
    _outbounceName.text = model.houseName;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _seletedView = [UIView new];
        [self.contentView addSubview:_seletedView];
        _seletedView.backgroundColor = LZAppBlueColor;
        [_seletedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(2);
        }];
        
        _outbounceName = [UILabel new];
        _outbounceName.font = [UIFont systemFontOfSize:14];
        _outbounceName.textColor = [UIColor darkGrayColor];
        _outbounceName.textAlignment = NSTextAlignmentCenter;
        _outbounceName.numberOfLines = 0;
        [self.contentView addSubview:_outbounceName];
        [_outbounceName mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.equalTo(_seletedView.mas_right).offset(3);
            make.center.equalTo(self.contentView);
        }];
        
    }
    return self;
}
@end
