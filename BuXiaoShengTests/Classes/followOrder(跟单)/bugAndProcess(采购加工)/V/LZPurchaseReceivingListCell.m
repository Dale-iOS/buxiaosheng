//
//  LZPurchaseReceivingListCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceivingListCell.h"
#import "LZPurchaseReceivingListModel.h"

@implementation LZPurchaseReceivingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        
        [self setLayout];
    }
    return self;
}

- (void)setLayout{
    ///白色底图
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5.0f;
    //    //        阴影的颜色
    //    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    //        阴影的透明度
    //    _bgView.layer.shadowOpacity = 0.6f;
    //    //        阴影的偏移量
    //    _bgView.layer.shadowOffset = CGSizeMake(4,4);
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        //        make.width.mas_offset(APPWidth -15*2);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    //仓库
    _warehouseLabel = [[UILabel alloc]init];
    _warehouseLabel.backgroundColor = [UIColor clearColor];
    _warehouseLabel.font = FONT(12);
    _warehouseLabel.textColor = CD_Text66;
    [_bgView addSubview:_warehouseLabel];
    [_warehouseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top).offset(15);
        make.left.equalTo(_bgView).offset(15);
        make.width.mas_offset(300);
        make.height.mas_offset(13);
    }];
    
    //数量
    _numLabel = [[UILabel alloc]init];
    _numLabel.backgroundColor = [UIColor clearColor];
    _numLabel.font = FONT(12);
    _numLabel.textColor = CD_Text66;
    [_bgView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_warehouseLabel.mas_bottom).offset(10);
        make.left.equalTo(_bgView).offset(15);
        make.width.mas_offset(300);
        make.height.mas_offset(13);
    }];
    
    //金额
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = FONT(12);
    _priceLabel.textColor = CD_Text66;
    [_bgView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLabel.mas_bottom).offset(10);
        make.left.equalTo(_bgView).offset(15);
        make.width.mas_offset(300);
        make.height.mas_offset(13);
    }];
    
    //时间
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = CD_Text99;
    [_bgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLabel.mas_bottom).offset(10);
        make.right.equalTo(_bgView).offset(-15);
        make.width.mas_offset(200);
        make.height.mas_offset(13);
    }];
}

- (void)setModel:(LZPurchaseReceivingListModel *)model{
    _model = model;
    _warehouseLabel.text = [NSString stringWithFormat:@"入库存：%@",model.houseName];
    _numLabel.text = [NSString stringWithFormat:@"入库数量：%@",model.houseNum];
    _priceLabel.text = [NSString stringWithFormat:@"实付金额：%@",model.realpayPrice];
    _timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
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
