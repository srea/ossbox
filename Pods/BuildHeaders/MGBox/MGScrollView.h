//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import <Foundation/Foundation.h>

@interface MGScrollView : UIScrollView

@property (nonatomic, retain) NSMutableArray *boxes;

- (void)drawBoxesWithSpeed:(NSTimeInterval)speed;
- (void)updateContentSize;
- (void)snapToNearestBox;

@end
