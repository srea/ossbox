//
//  Created by Matt Greenfield on 24/05/12.
//  Copyright (c) 2012 Big Paua. All rights reserved.
//  http://bigpaua.com/
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MGBoxProtocol.h"

@interface MGBox : UIView <MGBoxProtocol>

@property (nonatomic, retain) NSMutableArray *topLines;
@property (nonatomic, retain) NSMutableArray *middleLines;
@property (nonatomic, retain) NSMutableArray *bottomLines;
@property (nonatomic, retain) UIView *content;
@property (nonatomic, retain) id misc;

+ (id)box;
- (void)addLayers;
- (UIImage *)screenshot:(float)scale;

@end
