//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import "MGBoxLine.h"
#import "MGButton.h"

#define DEFAULT_HEIGHT      40.0
#define DEFAULT_WIDTH      304.0
#define DEFAULT_LINE_PADDING 4.0
#define DEFAULT_ITEM_PADDING 3.0

@interface MGBoxLine ()

- (UILabel *)makeLabel:(NSString *)text right:(BOOL)right;
- (void)removeOldContents;
- (CGFloat)layoutLeftWithin:(CGFloat)widthLimit;
- (CGFloat)layoutRightWithin:(CGFloat)widthLimit;

@end

@implementation MGBoxLine

@synthesize contentsLeft, contentsRight, underlineType, font, sidePrecedence;
@synthesize solidUnderline, leftViews, rightViews, rightFont;
@synthesize parentBox, misc, textColor;
@synthesize linePadding, itemPadding, height, width;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentsLeft = [NSMutableArray array];
        self.contentsRight = [NSMutableArray array];

        CGSize size = frame.size;
        self.width = frame.size.width;
        CGRect inner = CGRectMake(0, 0, size.width, size.height);
        self.rightViews = [[UIView alloc] initWithFrame:inner];
        self.leftViews = [[UIView alloc] initWithFrame:inner];
        rightViews.backgroundColor = [UIColor clearColor];
        leftViews.backgroundColor = [UIColor clearColor];
        [self addSubview:rightViews];
        [self addSubview:leftViews];

        self.height = DEFAULT_HEIGHT;
        self.linePadding = DEFAULT_LINE_PADDING;
        self.itemPadding = DEFAULT_ITEM_PADDING;
        self.sidePrecedence = MGSidePrecedenceLeft;
        self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        self.textColor = [UIColor blackColor];
        self.underlineType = MGUnderlineBottom;
    }
    return self;
}

+ (id)line {
    return [self lineWithWidth:0];
}

+ (id)lineWithWidth:(CGFloat)width {
    width = width ? width : DEFAULT_WIDTH;
    MGBoxLine *line = [[self alloc] initWithFrame:CGRectMake(0, 0,
            width, DEFAULT_HEIGHT)];
    return line;
}

+ (id)multilineWithText:(NSString *)text font:(UIFont *)font
                padding:(CGFloat)padding {
    return [self multilineWithText:text font:font padding:padding width:0];
}

+ (id)multilineWithText:(NSString *)text font:(UIFont *)font
                padding:(CGFloat)padding width:(CGFloat)width {
    width = width ? width : DEFAULT_WIDTH;
    font = font ? font : [UIFont fontWithName:@"HelveticaNeue-Light" size:14];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.text = text;
    CGSize fsize = [label.text sizeWithFont:label.font
            constrainedToSize:CGSizeMake(width - 24, 480)];
    label.frame = CGRectMake(0, 0, width - 24, fsize.height + padding);

    MGBoxLine *line = [self lineWithLeft:label right:nil width:width];
    line.height = label.frame.size.height;
    return line;
}

+ (id)lineWithLeft:(NSObject *)left right:(NSObject *)right {
    return [self lineWithLeft:left right:right width:0];
}

+ (id)lineWithLeft:(NSObject *)left right:(NSObject *)right
             width:(CGFloat)width {
    width = width ? width : DEFAULT_WIDTH;
    MGBoxLine *line = [[self alloc] initWithFrame:CGRectMake(0, 0,
            width, DEFAULT_HEIGHT)];
    if ([left isKindOfClass:[NSArray class]]) {
        line.contentsLeft = (NSMutableArray *)[left mutableCopy];
    } else {
        line.contentsLeft = left ? [NSMutableArray arrayWithObject:left] : nil;
    }
    if ([right isKindOfClass:[NSArray class]]) {
        line.contentsRight = (NSMutableArray *)[right mutableCopy];
    } else {
        line.contentsRight =
                right ? [NSMutableArray arrayWithObject:right] : nil;
    }
    return line;
}

- (UILabel *)makeLabel:(NSString *)text right:(BOOL)right {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = right && rightFont ? rightFont : font;
    label.textColor = textColor;
    label.lineBreakMode = right
            ? UILineBreakModeHeadTruncation
            : UILineBreakModeTailTruncation;
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    CGSize size = [label.text sizeWithFont:label.font];
    label.frame = CGRectMake(0, 0, size.width, height);
    return label;
}

- (void)layoutContents {
    if (!contentsLeft) {
        self.contentsLeft = [NSMutableArray array];
    }
    if (!contentsRight) {
        self.contentsRight = [NSMutableArray array];
    }
    [self removeOldContents];
    CGRect frame = self.frame;
    frame.size.width = self.width;
    self.frame = frame;
    if (sidePrecedence == MGSidePrecedenceLeft) {
        CGFloat remainder = [self layoutLeftWithin:self.width - linePadding];
        [self layoutRightWithin:remainder];
    } else {
        CGFloat remainder = [self layoutRightWithin:self.width - linePadding];
        [self layoutLeftWithin:remainder];
    }
}

- (void)removeOldContents {
    NSMutableArray *deletedPieces = [NSMutableArray array];
    for (UIView *view in leftViews.subviews) {
        if ([contentsLeft indexOfObject:view] == NSNotFound) {
            [deletedPieces addObject:view];
        }
    }
    for (UIView *view in rightViews.subviews) {
        if ([contentsRight indexOfObject:view] == NSNotFound) {
            [deletedPieces addObject:view];
        }
    }
    [deletedPieces makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (CGFloat)layoutLeftWithin:(CGFloat)widthLimit {
    CGFloat x = linePadding + itemPadding;

    int i;
    for (i = 0; i < [contentsLeft count]; i++) {
        id piece = [contentsLeft objectAtIndex:i];

        // wrap NSStrings in UILabels
        if ([piece isKindOfClass:[NSString class]]) {
            x += itemPadding;
            UILabel *label = [self makeLabel:(NSString *)piece right:NO];
            CGSize size = label.frame.size;
            if (x + size.width > widthLimit) { // needs slimming
                size.width = widthLimit - x > 0 ? widthLimit - x : 0;
            }
            label.frame = CGRectMake(x, 0, size.width, size.height);
            [leftViews addSubview:label];
            x += size.width + itemPadding;

            // MGButtons are special
        } else if ([piece isKindOfClass:[MGButton class]]) {
            MGButton *button = piece;
            button.maxWidth = 0;
            CGSize size = button.frame.size;
            if (x + size.width > widthLimit) { // needs slimming
                button.maxWidth = widthLimit - x > 0 ? widthLimit - x : 0;
                size = button.frame.size;
            }
            button.frame = CGRectMake(x, button.frame.origin.y, size.width,
                    size.height);
            [leftViews addSubview:button];
            x += button.frame.size.width;

        } else { // hopefully is a UIView or UIImage then
            UIView *view =
                    [piece isKindOfClass:[UIImage class]] ? [[UIImageView alloc]
                           initWithImage:piece] : piece;
            CGSize size = view.frame.size;
            x += itemPadding; // left pad arbitrary views
            CGFloat y = height / 2 - view.frame.size.height / 2;
            view.frame = CGRectMake(x, roundf(y), size.width, size.height);
            x += itemPadding; // right pad aribtrary views
            [leftViews addSubview:view];
            x += view.frame.size.width;
        }

        // out of room!
        if (x > widthLimit) {
            break;
        }
    }

    // ditch leftovers if out of room
    if (i < [contentsLeft count]) {
        for (; i < [contentsLeft count]; i++) {
            if ([[contentsLeft objectAtIndex:i] isKindOfClass:[UIView class]]) {
                [[contentsLeft objectAtIndex:i] removeFromSuperview];
            }
        }
    }

    leftViews.frame = CGRectMake(0, 0, x, height);
    return self.frame.size.width - x;
}

- (CGFloat)layoutRightWithin:(CGFloat)widthLimit {
    CGFloat x = self.frame.size.width - linePadding - itemPadding;
    CGFloat minX = self.frame.size.width - widthLimit;
    int i;
    for (i = 0; i < [contentsRight count]; i++) {
        id piece = [contentsRight objectAtIndex:i];

        // wrap strings in UILabels
        if ([piece isKindOfClass:[NSString class]]) {
            x -= itemPadding; // right pad labels
            UILabel *label = [self makeLabel:(NSString *)piece right:YES];
            label.textAlignment = UITextAlignmentRight;
            CGSize size = label.frame.size;
            if (x - size.width < minX) { // needs slimming
                size.width = x - minX > 0 ? x - minX : 0;
                x = minX;
            } else { // it fits
                x -= size.width;
            }
            label.frame = CGRectMake(x, 0, size.width, size.height);
            [rightViews addSubview:label];
            x -= itemPadding;

            // MGButtons are special
        } else if ([piece isKindOfClass:[MGButton class]]) {
            MGButton *view = piece;
            view.maxWidth = 0;
            CGSize size = view.frame.size;
            if (x - size.width < minX) { // needs slimming
                view.maxWidth = x - minX > 0 ? x - minX : 0;
                size = view.frame.size;
                x = minX;
            } else { // it fits
                x -= size.width;
            }
            view.frame =
                    CGRectMake(x, view.frame.origin.y, size.width, size.height);
            [rightViews addSubview:view];

        } else { // hopefully is a UIView or UIImage then
            UIView *view =
                    [piece isKindOfClass:[UIImage class]] ? [[UIImageView alloc]
                           initWithImage:piece] : piece;
            CGSize size = view.frame.size;
            x -= size.width;
            x -= itemPadding; // right pad arbitrary views
            CGFloat y = height / 2 - view.frame.size.height / 2;
            view.frame = CGRectMake(x, roundf(y), size.width, size.height);
            x -= itemPadding; // left pad arbitrary views
            [rightViews addSubview:view];
        }

        // out of room!
        if (x < minX) {
            break;
        }
    }

    // ditch leftovers if out of room
    if (i < [contentsRight count]) {
        for (; i < [contentsRight count]; i++) {
            if ([[contentsRight objectAtIndex:i]
                                isKindOfClass:[UIView class]]) {
                [[contentsRight objectAtIndex:i] removeFromSuperview];
            }
        }
    }

    return x;
}

- (void)setHeight:(CGFloat)_height {
    height = _height;
    CGPoint pos = self.frame.origin;
    CGSize size = self.frame.size;
    self.frame = CGRectMake(pos.x, pos.y, size.width, height);
    self.underlineType = underlineType;
}

- (void)setUnderlineType:(UnderlineType)type {
    underlineType = type;
    CGSize size = self.frame.size;
    switch (underlineType) {
    case MGUnderlineTop:
        self.solidUnderline.frame = CGRectMake(0, 0, size.width, 2);
        [self.layer addSublayer:self.solidUnderline];
        break;
    case MGUnderlineBottom:
        self.solidUnderline.frame =
                CGRectMake(0, size.height - 1, size.width, 2);
        [self.layer addSublayer:self.solidUnderline];
        break;
    case MGUnderlineNone:
    default:
        [self.solidUnderline removeFromSuperlayer];
        break;
    }
    [self bringSubviewToFront:rightViews];
    [self bringSubviewToFront:leftViews];
}

- (CALayer *)solidUnderline {
    if (solidUnderline) {
        return solidUnderline;
    }
    solidUnderline = [CALayer layer];
    solidUnderline.frame = CGRectMake(0, 0, self.frame.size.width, 2);
    solidUnderline.backgroundColor =
            [UIColor colorWithWhite:0.87 alpha:1].CGColor;
    CALayer *bot = [CALayer layer];
    bot.frame = CGRectMake(0, 1, self.frame.size.width, 1);
    bot.backgroundColor = [UIColor whiteColor].CGColor;
    [solidUnderline addSublayer:bot];
    return solidUnderline;
}

@end
