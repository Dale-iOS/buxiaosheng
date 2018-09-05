//
//  CellImageCollVi.m
//  UICollectionViewss
//
//  Created by 幸福的尾巴 on 2018/8/30.
//  Copyright © 2018年 幸福的尾巴. All rights reserved.
//

#import "CellImageCollVi.h"
#import "UIView+Layout.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImagePickerController.h"

@implementation CellImageCollVi
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		_imageView = [[UIImageView alloc] init];
		_imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.image = [UIImage imageNamedFromMyBundle:@"add_image"];
		[self addSubview:_imageView];
		self.clipsToBounds = YES;

		_deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_deleteBtn setImage:[UIImage imageNamed:@"delete_jurisdiction"] forState:UIControlStateNormal];
		_deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
		_deleteBtn.alpha = 0.6;
		[self addSubview:_deleteBtn];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_imageView.frame = self.bounds;
	_deleteBtn.frame = CGRectMake(self.tz_width - 20, 0, 20, 20);
}

- (void)setRow:(NSInteger)row {
	_row = row;
	_deleteBtn.tag = row;
}
@end
