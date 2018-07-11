//
//  SetBranchCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SetBranchCell.h"

@implementation SetBranchCell
@synthesize typeItem,branchNameItem,settlementItem,assignmentItem,stateItem;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setSDlayout];
        
    }
    return self;
}

#pragma mark ------- lazy loading ---------
- (TextInputCell *)typeItem
{
    if (!typeItem) {
        
        TextInputCell *item = [[TextInputCell alloc]init];
        item.titleLabel.text = @"类型";
        [contentView addSubview:(typeItem = item)];
    }
    return typeItem;
}

- (TextInputCell *)branchNameItem
{
    if (!branchNameItem) {
        
        TextInputCell *item = [[TextInputCell alloc]init];
        item.titleLabel.text = @"分店名称";
        [contentView addSubview:(branchNameItem = item)];
    }
    return branchNameItem;
}

- (TextInputCell *)settlementItem
{
    if (!settlementItem) {
        
        TextInputCell *item = [[TextInputCell alloc]init];
        item.titleLabel.text = @"是否结算分店";
        [contentView addSubview:(settlementItem = item)];
    }
    return settlementItem;
}

- (TextInputCell *)assignmentItem
{
    if (!assignmentItem) {
        
        TextInputCell *item = [[TextInputCell alloc]init];
        item.titleLabel.text = @"是否接受任务";
        [contentView addSubview:(assignmentItem = item)];
    }
    return assignmentItem;
}

- (TextInputCell *)stateItem
{
    if (!stateItem) {
        
        TextInputCell *item = [[TextInputCell alloc]init];
        item.titleLabel.text = @"状态";
        [contentView addSubview:(stateItem = item)];
    }
    return stateItem;
}

- (void)setSDlayout
{
    //顶部灰色条
    UIView *grayLineView = [[UIView alloc]init];
    grayLineView.backgroundColor = LZHBackgroundColor;
    [contentView addSubview:grayLineView];
    grayLineView.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(10);
    
    //顶部白色
    UIView *whiteHeadView = [[UIView alloc]init];
    whiteHeadView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:whiteHeadView];
    whiteHeadView.sd_layout
    .topSpaceToView(grayLineView, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(29);
    
    //分店n
    self.branchNumLbl = [[UILabel alloc]init];
    self.branchNumLbl.text = @"分店1";
    self.branchNumLbl.textColor = CD_Text99;
    self.branchNumLbl.font = FONT(12);
    [whiteHeadView addSubview:self.branchNumLbl];
    self.branchNumLbl.sd_layout
    .centerYEqualToView(whiteHeadView)
    .leftSpaceToView(whiteHeadView, 15)
    .widthIs(100)
    .heightIs(13);
    
    //修改按钮底图
    UIView *alterBgView = [[UIView alloc]init];
    alterBgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *alterTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterTapAction)];
    [alterBgView addGestureRecognizer:alterTap];
    [whiteHeadView addSubview:alterBgView];
    alterBgView.sd_layout
    .heightRatioToView(whiteHeadView, 1)
    .rightSpaceToView(whiteHeadView, 15)
    .widthIs(45)
    .topSpaceToView(whiteHeadView, 0);
    
    UILabel *alterLbl = [[UILabel alloc]init];
    alterLbl.text = @"修改";
    alterLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    alterLbl.font = FONT(12);
    [alterBgView addSubview:alterLbl];
    alterLbl.sd_layout
    .leftSpaceToView(alterBgView, 0)
    .centerYEqualToView(alterBgView)
    .widthIs(25)
    .heightIs(13);
    
    UIImageView *alterIMV = [[UIImageView alloc]init];
    alterIMV.image = IMAGE(@"alter");
    [alterBgView addSubview:alterIMV];
    alterIMV.sd_layout
    .rightSpaceToView(alterBgView, 0)
    .centerYEqualToView(alterBgView)
    .heightIs(15)
    .widthIs(15);
    
    self.typeItem.sd_layout
    .topSpaceToView(whiteHeadView, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    self.branchNameItem.sd_layout
    .topSpaceToView(self.typeItem, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    self.settlementItem.sd_layout
    .topSpaceToView(self.branchNameItem, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    self.assignmentItem.sd_layout
    .topSpaceToView(self.settlementItem, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    self.stateItem.sd_layout
    .topSpaceToView(self.assignmentItem, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
}

- (void)alterTapAction
{
    if ([self.delegate respondsToSelector:@selector(didClickAlterBtnInCell:)]) {
        
        [self.delegate didClickAlterBtnInCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
