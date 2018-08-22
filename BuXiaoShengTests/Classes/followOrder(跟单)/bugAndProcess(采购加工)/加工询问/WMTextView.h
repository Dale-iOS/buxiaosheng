//
//  WMTextView.h
//  WB2
//
//  Created by WM on 15/12/31.
//  Copyright © 2015年 王猛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Positioning.m"

@interface WMTextView : UITextView

@property (nonatomic,copy) NSString *placeHolder;

@property (nonatomic,assign) BOOL hidePlaceHolder;

@end
