//
//  BXSMachiningDBHeaderfooterView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSMachiningDBHeaderfooterView.h"

@implementation BXSMachiningDBHeaderfooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        if ([reuseIdentifier isEqualToString:@"header"]) {
            [self setupHeader];
        }else{
            [self setupFooter];
        }
    }
    
    return self;
}

- (void)setupHeader {
    self.contentView.backgroundColor = RGB(220, 234, 253);
    
    self.colorlabel = [UILabel labelWithColor:CD_Text33 font:FONT(14)];
    [self.contentView addSubview:self.colorlabel];
    self.colorlabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(120);
    
    self.needLabel = [UILabel labelWithColor:CD_Text33 font:FONT(14)];
    [self.contentView addSubview:self.needLabel];
    self.needLabel.sd_layout
    .xIs(APPWidth/2)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(150);
    
    
}

- (void)setupFooter {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:addBtn];
    [addBtn setImage:IMAGE(@"addBottom") forState:UIControlStateNormal];
    addBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .centerXEqualToView(self.contentView)
    .widthIs(150).heightIs(40);
    self.addDBButton = addBtn;
    
}
@end
