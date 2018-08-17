//
//  LZOutboundCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundCell.h"
#import "LZOutboundListCell.h"
#import "OutboundViewController.h"
@interface LZOutboundCell()<UITextFieldDelegate>
@end
@implementation LZOutboundCell
{
    // UIButton *_addBtn;
    //    UIView *_headView;
    //    UIView *_footView;
    //库存数量
    UILabel * _warehouseNumLbl;
    //出库数量
    UITextField * _OutNumLbl;
    //条数
    UILabel * _lineNumLbl;
    //出库仓
    UILabel * _fromWarahouseLbl ;
}

-(void)setItemsModel:(LLOutboundRightModel *)itemsModel {
    _itemsModel = itemsModel;
    
    _warehouseNumLbl.text = _itemsModel.number;
    _lineNumLbl.text =_itemsModel.total;
    _fromWarahouseLbl.text = itemsModel.leftModel.houseName;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    //    _headView = [[UIView alloc]init];
    //    _headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    //    [self.contentView addSubview:_headView];
    
    UILabel *warehouseNumLbl = [[UILabel alloc]init];
    _warehouseNumLbl = warehouseNumLbl;
    warehouseNumLbl.font = FONT(14);
    warehouseNumLbl.textColor = CD_Text33;
    warehouseNumLbl.textAlignment = NSTextAlignmentCenter;
    warehouseNumLbl.text = @"库存数量";
    [self.contentView addSubview:warehouseNumLbl];
    [warehouseNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UITextField *OutNumLbl = [[UITextField alloc]init];
    OutNumLbl.userInteractionEnabled = true;
    OutNumLbl.keyboardType = UIKeyboardTypeNumberPad;
    _OutNumLbl = OutNumLbl;
    OutNumLbl.font = FONT(14);
    OutNumLbl.delegate = self;
    OutNumLbl.textColor = CD_Text33;
    OutNumLbl.textAlignment = NSTextAlignmentCenter;
    OutNumLbl.placeholder = @"出库数量";
    [self.contentView addSubview:OutNumLbl];
    [OutNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(warehouseNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *lineNumLbl = [[UILabel alloc]init];
    _lineNumLbl = lineNumLbl;
    lineNumLbl.font = FONT(14);
    lineNumLbl.textColor = CD_Text33;
    lineNumLbl.textAlignment = NSTextAlignmentCenter;
    lineNumLbl.text = @"条数";
    [self.contentView addSubview:lineNumLbl];
    [lineNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(OutNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *fromWarahouseLbl = [[UILabel alloc]init];
    _fromWarahouseLbl = fromWarahouseLbl;
    fromWarahouseLbl.font = FONT(14);
    fromWarahouseLbl.textColor = CD_Text33;
    fromWarahouseLbl.textAlignment = NSTextAlignmentCenter;
    fromWarahouseLbl.text = @"出库仓";
    [self.contentView addSubview:fromWarahouseLbl];
    [fromWarahouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(lineNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.itemsModel.outgoingCount = textField.text;
    
    OutboundViewController * outVc = (OutboundViewController*)[BXSTools viewWithViewController:self.contentView];
    [outVc.tableView reloadData];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

