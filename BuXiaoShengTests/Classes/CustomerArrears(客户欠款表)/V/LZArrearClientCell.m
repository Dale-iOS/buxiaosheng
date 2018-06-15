//
//  LZArrearClientCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZArrearClientCell.h"

@implementation LZArrearClientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    _oneLbl = [[UILabel alloc]init];
    _oneLbl.font = FONT(14);
    _oneLbl.textColor = CD_Text33;
    _oneLbl.textAlignment = NSTextAlignmentCenter;
    _oneLbl.text = @"客户名称";
    _oneLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    _oneLbl.backgroundColor = [UIColor redColor];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
