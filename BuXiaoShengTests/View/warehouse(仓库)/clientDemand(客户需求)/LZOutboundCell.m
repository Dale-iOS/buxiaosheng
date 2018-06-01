//
//  LZOutboundCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundCell.h"
#import "LZOutboundListCell.h"
@interface LZOutboundCell()
@end
@implementation LZOutboundCell
{
   // UIButton *_addBtn;
    UIView *_headView;
    UIView *_footView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.contentView addSubview:_headView];
   
    UILabel *warehouseNumLbl = [[UILabel alloc]init];
    warehouseNumLbl.font = FONT(14);
    warehouseNumLbl.textColor = CD_Text33;
    warehouseNumLbl.textAlignment = NSTextAlignmentCenter;
    warehouseNumLbl.text = @"库存数量";
    [_headView addSubview:warehouseNumLbl];
    [warehouseNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *OutNumLbl = [[UILabel alloc]init];
    OutNumLbl.font = FONT(14);
    OutNumLbl.textColor = CD_Text33;
    OutNumLbl.textAlignment = NSTextAlignmentCenter;
    OutNumLbl.text = @"出库数量";
    [_headView addSubview:OutNumLbl];
    [OutNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(warehouseNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *lineNumLbl = [[UILabel alloc]init];
    lineNumLbl.font = FONT(14);
    lineNumLbl.textColor = CD_Text33;
    lineNumLbl.textAlignment = NSTextAlignmentCenter;
    lineNumLbl.text = @"条数";
    [_headView addSubview:lineNumLbl];
    [lineNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(OutNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *fromWarahouseLbl = [[UILabel alloc]init];
    fromWarahouseLbl.font = FONT(14);
    fromWarahouseLbl.textColor = CD_Text33;
    fromWarahouseLbl.textAlignment = NSTextAlignmentCenter;
    fromWarahouseLbl.text = @"出库仓";
    [_headView addSubview:fromWarahouseLbl];
    [fromWarahouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(lineNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
   
    
    
    //tableview尾部试图
    _footView = [[UIView alloc]init];
    _footView.backgroundColor = [UIColor whiteColor];
    //总库存数
    UILabel *totalWarehousLbl = [[UILabel alloc]init];
    totalWarehousLbl.textAlignment = NSTextAlignmentCenter;
    totalWarehousLbl.textColor = CD_Text99;
    totalWarehousLbl.font = FONT(13);
    totalWarehousLbl.text = @"总库存数量：";
    [_footView addSubview:totalWarehousLbl];
    [totalWarehousLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_footView);
        make.width.mas_offset(APPWidth *0.5);
        make.height.mas_offset(44);
    }];
    //总出库数
    UILabel *totalOutWarehousLbl = [[UILabel alloc]init];
    totalOutWarehousLbl.textAlignment = NSTextAlignmentCenter;
    totalOutWarehousLbl.textColor = CD_Text99;
    totalOutWarehousLbl.font = FONT(13);
    totalOutWarehousLbl.text = @"总出库存数：";
    [_footView addSubview:totalOutWarehousLbl];
    [totalOutWarehousLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_footView);
        make.width.mas_offset(APPWidth *0.5);
        make.height.mas_offset(44);
    }];

}


- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

