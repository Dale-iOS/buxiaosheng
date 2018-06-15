//
//  LLBackOderDetailCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLBackOderDetailCell.h"
#import "LLBackOrdeContentModel.h"
@implementation LLBackOderDetailCell

-(void)setModel:(LLBackOrdeContentModel *)model {
    _model = model;
    self.titleLabel.text = model.leftTitle;
    self.rightArrowImageVIew.hidden = _model.rightArrowHidden;
    self.contentTF.placeholder = model.placeholder;
    self.contentTF.text = model.content;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentTF];
        [self.contentView addSubview:self.hintLabel];
        [self.contentView addSubview:self.rightArrowImageVIew];
        
        //        [self setNeedsUpdateConstraints];
        [self setupSDlayout];
    }
    return self;
}

#pragma mark ----- lazy loding -----
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:(_titleLabel = label)];
    }
    return _titleLabel;
}

- (UITextField *)contentTF
{
    if (!_contentTF) {
        
        UITextField *tf = [[UITextField alloc]init];
        tf.textColor = CD_Text33;
        tf.font = FONT(14);
        //        tf.backgroundColor = [UIColor redColor];
        tf.textAlignment = NSTextAlignmentLeft;
        //        tf.delegate = self;
        //        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:(_contentTF = tf)];
    }
    return _contentTF;
}

- (UILabel *)hintLabel
{
    if (!_hintLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_textCC;
        label.text = @"选择收款方式";
        label.hidden = YES;
        label.textAlignment = NSTextAlignmentLeft;
        //        label.hidden = YES;
        [self addSubview:(_hintLabel = label)];
    }
    return _hintLabel;
}

- (UIImageView *)rightArrowImageVIew
{
    if (!_rightArrowImageVIew) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.hidden = YES;
        imageView.image = IMAGE(@"rightarrow");
        [self addSubview:(_rightArrowImageVIew = imageView)];
    }
    return _rightArrowImageVIew;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self addSubview:(_lineView = view)];
    }
    return _lineView;
}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).with.offset(15);
//        make.centerY.equalTo(self.mas_centerY);
//
//    }];
//}

//自动布局
- (void)setupSDlayout
{
    self.titleLabel.sd_layout
    //    .topSpaceToView(self, 1)
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .heightRatioToView(self.contentView, 1)
    .widthIs(100);
    
    self.contentTF.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.titleLabel, 50)
    .heightRatioToView(self.contentView, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    self.rightArrowImageVIew.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(8)
    .heightIs(14);
    
    self.hintLabel.sd_layout
    .topEqualToView(self.contentView)
    .rightSpaceToView(self.rightArrowImageVIew, 10)
    //    .heightRatioToView(self, 1)
    .widthIs(90)
    .heightRatioToView(self.contentView, 1);
    
    self.lineView.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .widthRatioToView(self.contentView, 1)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(1);
}


@end
