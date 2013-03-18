// AKTab.h
//
// Copyright (c) 2012 Ali Karagoz (http://alikaragoz.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <QuartzCore/QuartzCore.h>

@interface AKTab : UIButton

// Image used to draw the icon.
@property (nonatomic, strong) NSString *tabImageWithName;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

// Tab selected background image
@property (nonatomic, strong) NSString *selectedBackgroundImageName;

// Tab text color
@property (nonatomic, strong) UIColor *textColor;

// Tab selected text color
@property (nonatomic, strong) UIColor *selectedTextColor;

// Tabs title.
@property (nonatomic, strong) NSString *tabTitle;

// Tabs icon colors.
@property (nonatomic, strong) NSArray *tabIconColors;

// Tabs selected icon colors.
@property (nonatomic, strong) NSArray *tabIconColorsSelected;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabSelectedColors;

// Tabs icon glossy show / hide
@property (nonatomic, assign) BOOL glossyIsHidden;

// Tab stroke Color
@property (nonatomic, strong) UIColor *strokeColor;

// Tab top embos Color
@property (nonatomic, strong) UIColor *edgeColor;

// Height of the tab bar.
@property (nonatomic, assign) CGFloat tabBarHeight;

// Minimum height that permits the display of the tab's title.
@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;

// Used to show / hide title.
@property (nonatomic, assign) BOOL titleIsHidden;

@end
