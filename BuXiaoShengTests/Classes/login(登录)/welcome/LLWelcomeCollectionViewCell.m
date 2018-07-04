//
//  LLWelcomeCollectionViewCell.m
//  JLCSteelProject
//
//  Created by 周尊贤 on 2017/9/20.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLWelcomeCollectionViewCell.h"

@implementation LLWelcomeCollectionViewCell
{
    
    UIImageView * _iconImage;
}


-(void)setIconImageStr:(NSString *)iconImageStr {
    
    _iconImageStr = iconImageStr;

    _iconImage.image = [UIImage imageNamed:iconImageStr];
}
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _iconImage = [UIImageView new];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.clipsToBounds = true;
        _iconImage.backgroundColor = [UIColor redColor];
       // [_iconImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
      //  _iconImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
@end
