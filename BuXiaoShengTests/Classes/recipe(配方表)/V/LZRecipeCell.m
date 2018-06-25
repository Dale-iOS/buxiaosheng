//
//  LZRecipeCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZRecipeCell.h"

@implementation LZRecipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = LZHBackgroundColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    //第一个line
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView1.backgroundColor = LZHBackgroundColor;
    [self.contentView addSubview:lineView1];
    
    //配方材料
    self.materialsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, lineView1.bottom +0.5, APPWidth, 49)];
    self.materialsCell.titleLabel.text = @"配方材料";
    self.materialsCell.contentTF.placeholder = @"请选择配方材料";
    self.materialsCell.backgroundColor = [UIColor whiteColor];
    self.materialsCell.rightArrowImageVIew.hidden = NO;
    [self.contentView addSubview:self.materialsCell];
    
    //颜色
    self.colorCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.materialsCell.bottom +0.5, APPWidth, 49)];
    self.colorCell.titleLabel.text = @"颜色";
    self.colorCell.contentTF.placeholder = @"请选择颜色";
    self.colorCell.backgroundColor = [UIColor whiteColor];
    self.colorCell.rightArrowImageVIew.hidden = NO;
    [self.contentView addSubview:self.colorCell];
    
    //单位
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.colorCell.bottom +0.5, APPWidth, 49)];
    self.unitCell.titleLabel.text = @"单位";
    self.unitCell.contentTF.placeholder = @"请输入单位";
    self.unitCell.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.unitCell];
    
    //材料用量
    self.amountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.unitCell.bottom +0.5, APPWidth, 49)];
    self.amountCell.titleLabel.text = @"材料用量";
    self.amountCell.contentTF.placeholder = @"请输入材料用量";
    self.amountCell.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.amountCell];
    
    //计算损耗
    self.wastageCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.amountCell.bottom +0.5, APPWidth, 49)];
    self.wastageCell.titleLabel.text = @"计算损耗";
    self.wastageCell.contentTF.placeholder = @"请输入计算损耗";
    self.wastageCell.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.wastageCell];
    
    //计划用量
    self.planAmountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.wastageCell.bottom +0.5, APPWidth, 49)];
    self.planAmountCell.titleLabel.text = @"计划用量";
    self.planAmountCell.contentTF.placeholder = @"请输入计划用量";
    self.planAmountCell.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.planAmountCell];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
