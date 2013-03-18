//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import "MGScrollView.h"
#import "MGBoxProtocol.h"

#define BOTTOM_MARGIN 10.0

@implementation MGScrollView

@synthesize boxes;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.boxes = [NSMutableArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.boxes = [NSMutableArray array];
    }
    return self;
}

- (void)drawBoxesWithSpeed:(NSTimeInterval)speed {

    // prep frame sizes
    [boxes makeObjectsPerformSelector:@selector(draw)];

    // set y for new top boxes
    CGFloat offsetY = 0;
    NSMutableArray *newTopBoxes = [NSMutableArray array];
    for (UIView <MGBoxProtocol> *box in boxes) {
        if (box.isReplacement) {
            box.alpha = 0;
            box.isReplacement = NO;
            break;
        }
        if ([self.subviews indexOfObject:box] != NSNotFound) {
            break;
        }
        offsetY += box.topMargin;
        CGPoint pos = box.frame.origin;
        CGSize size = box.frame.size;
        box.frame = CGRectMake(pos.x, pos.y + offsetY, size.width, size.height);
        offsetY += box.frame.size.height + box.bottomMargin;
        [newTopBoxes addObject:box];
    }

    // move top new boxes above the top
    for (UIView <MGBoxProtocol> *box in newTopBoxes) {
        box.alpha = 0;
        box.center = CGPointMake(box.center.x, box.center.y - offsetY);
        [self addSubview:box];
    }

    // prep pre animation y positions for remaining new boxes
    CGFloat preAnimY = 0;
    for (UIView <MGBoxProtocol> *box in boxes) {
        if ([newTopBoxes indexOfObject:box] != NSNotFound) {
            continue; // new top boxes are already positioned
        }
        preAnimY += box.topMargin;
        CGPoint pos = box.frame.origin;
        CGSize size = box.frame.size;
        if ([self.subviews indexOfObject:box] == NSNotFound) {
            box.alpha = 0;
            box.frame = CGRectMake(pos.x, preAnimY, size.width, size.height);
            [self addSubview:box];
        }
        preAnimY += size.height + box.bottomMargin;
        [self bringSubviewToFront:box];
    }

    // find gone boxes
    NSMutableArray *goneBoxes = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view conformsToProtocol:@protocol(MGBoxProtocol)]
            && [boxes indexOfObject:view] == NSNotFound) {
            [goneBoxes addObject:view];
        }
    }

    // animation all to final y and alpha
    [UIView animateWithDuration:speed animations:^{

        // gone boxes move & fade out
        for (UIView <MGBoxProtocol> *box in goneBoxes) {
            box.alpha = 0;
        }

        // new/existing boxes move & fade in
        CGFloat finalY = 0;
        for (UIView <MGBoxProtocol> *box in boxes) {
            CGPoint pos = box.frame.origin;
            CGSize size = box.frame.size;
            finalY += box.topMargin;
            box.frame = CGRectMake(pos.x, finalY, size.width, size.height);
            box.alpha = 1;
            finalY += size.height + box.bottomMargin;
        }

    } completion:^(BOOL done) {
        [goneBoxes makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self updateContentSize];
        [self flashScrollIndicators];
    }];
}

- (void)updateContentSize {
    CGFloat height = 0;
    for (UIView <MGBoxProtocol> *box in boxes) {
        height += box.topMargin + box.frame.size.height + box.bottomMargin;
    }
    height += BOTTOM_MARGIN; // pad the bottom of the box
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}

- (void)snapToNearestBox {
    if (self.contentSize.height <= self.frame.size.height) {
        return;
    }
    if ([self.boxes count] < 2) {
        return;
    }

    CGSize size = self.frame.size;
    CGPoint offset = self.contentOffset;
    CGFloat fromBottom = self.contentSize.height - (offset.y + size.height);
    CGFloat fromTop = offset.y;
    CGFloat newY = 0;

    // near the bottom? then snap to
    UIView *last = [self.boxes lastObject];
    if (fromBottom < last.frame.size.height / 2 && fromBottom < fromTop) {
        newY = self.contentSize.height - size.height;

    } else { // find nearest box
        CGFloat oldY = offset.y;
        CGFloat diff = self.contentSize.height;
        for (UIView *box in self.boxes) {
            if (ABS(box.frame.origin.y - BOTTOM_MARGIN - oldY) < diff) {
                diff = ABS(box.frame.origin.y - oldY);
                newY = box.frame.origin.y - BOTTOM_MARGIN;
            }
        }
    }

    [UIView animateWithDuration:0.1 animations:^{
        self.contentOffset = CGPointMake(0, newY);
    }];
}

@end
