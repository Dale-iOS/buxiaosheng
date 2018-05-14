//
//  LZSearchBar.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LZSearchBarIconAlign) {
    LZSearchBarIconAlignLeft,
    LZSearchBarIconAlignCenter
};
@class LZSearchBar;
@protocol LZSearchBarDelegate <UIBarPositioningDelegate>

@optional

-(BOOL)searchBarShouldBeginEditing:(LZSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(LZSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(LZSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(LZSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(LZSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; // called before text changes

- (void)searchBarSearchButtonClicked:(LZSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(LZSearchBar *)searchBar;                     // called when cancel button pressed
// called when cancel button pressed
@end


@interface LZSearchBar : UIView<UITextInputTraits>

@property(nonatomic,assign) id<LZSearchBarDelegate> delegate;              // weak reference. default is nil
@property(nonatomic,copy)   NSString               *text;                  // current/starting search text
@property(nonatomic,retain) UIColor                *textColor;
@property(nonatomic,retain) UIFont                 *textFont;
@property(nonatomic,copy)   NSString               *placeholder;           // default is nil
@property(nonatomic,retain) UIColor                *placeholderColor;
@property(nonatomic,retain) UIImage                *iconImage;
@property(nonatomic,retain) UIImage                *backgroundImage;

@property(nonatomic,retain) UIButton *cancelButton; //lazy


@property(nonatomic,assign) UITextBorderStyle       textBorderStyle;
@property(nonatomic)        UIKeyboardType          keyboardType;
@property(nonatomic)        LZSearchBarIconAlign    iconAlign;     //text aligh model


@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;
@property (nonatomic, readwrite, retain) UIView *inputView;

-(BOOL)resignFirstResponder;
-(void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;
@end


