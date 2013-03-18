//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class MGBox;

typedef enum {
    MGUnderlineNone, MGUnderlineTop, MGUnderlineBottom
} UnderlineType;

typedef enum {
    MGSidePrecedenceLeft, MGSidePrecedenceRight
} SidePrecedence;

@interface MGBoxLine : UIView

@property (nonatomic, retain) NSMutableArray *contentsLeft;
@property (nonatomic, retain) NSMutableArray *contentsRight;
@property (nonatomic, assign) UnderlineType underlineType;
@property (nonatomic, assign) SidePrecedence sidePrecedence;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIFont *rightFont;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) MGBox *parentBox;
@property (nonatomic, retain) CALayer *solidUnderline;
@property (nonatomic, assign) CGFloat linePadding;
@property (nonatomic, assign) CGFloat itemPadding;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, retain) UIView *leftViews;
@property (nonatomic, retain) UIView *rightViews;
@property (nonatomic, retain) id misc;

+ (id)line;
+ (id)lineWithWidth:(CGFloat)width;
+ (id)lineWithLeft:(NSObject *)left right:(NSObject *)right;
+ (id)lineWithLeft:(NSObject *)left right:(NSObject *)right
             width:(CGFloat)width;
+ (id)multilineWithText:(NSString *)text font:(UIFont *)font
                padding:(CGFloat)padding;
+ (id)multilineWithText:(NSString *)text font:(UIFont *)font
                padding:(CGFloat)padding width:(CGFloat)width;
- (void)layoutContents;

- (UILabel *)makeLabel:(NSString *)text right:(BOOL)right;

@end
