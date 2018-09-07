//
//  LLColorRegisterCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLColorRegisterCell.h"
#import "TextInputCell.h"
@implementation LLColorRegisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.itemView = [TextInputCell new];
        [self.contentView addSubview:self.itemView];
        [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end

@interface LLColorRegisterImageCell()
@property(nonatomic ,strong)UIImageView * Iv;
@property(nonatomic ,strong)UIButton * deleteBtn;
@end
@implementation LLColorRegisterImageCell

-(void)setImage:(UIImage *)image {
    _image = image;
    _Iv.image = image;
    
    self.deleteBtn.hidden = ([image isEqual: [UIImage imageNamed:@"add_image"]]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.Iv = [UIImageView new];
        self.Iv.userInteractionEnabled = true;
        [self.contentView addSubview:self.Iv];
        [self.Iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.deleteBtn = [UIButton new];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"del_image"] forState:UIControlStateNormal];
        self.deleteBtn.hidden = true;
        [self.Iv addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.Iv).offset(-2);
            make.top.equalTo(self.Iv).offset(2);
        }];
    }
    return self;
}

-(void)deleteBtnClick {
    self.block(self);
}
@end

