# MGBox - A UITableView replacement with simplified API

Designed for rapid table creation with minimal code, easy customisation, attractive default styling, and with most common design patterns automated without need for fidgety UIView tweaking.

## Key Features

- Box lines accept and automatically lay out arbitrary arrays of `UIViews`, 
  `NSStrings`, and `UIImages`
- Create box lines with multiline text, automatically formatted and sized
- Intelligent handling of space limitations, with optional left or right side 
  precedence 
- Separate arrays for `topLines`, `middleLines`, and `bottomLines`, to simplify 
  common layout patterns
- A convenience `screenshot` method for capturing `UIImages` of boxes with OS X 
  screenshot style drop shadows
- Animations for box adding, removing, and moving  
- Optional edge snapping on scroll

## Example Screenshots

Complex box layouts created with simple code.

### Created with the convenience "screenshot" method:

![IfAlarm Screenshot 1](http://cloud.github.com/downloads/sobri909/MGBox/Screenshot1.png)
![IfAlarm Screenshot 2](http://cloud.github.com/downloads/sobri909/MGBox/Screenshot2.png)

(From [IfAlarm](http://ifalarm.com))

### The demo app:

![Demo App Screenshot](http://cloud.github.com/downloads/sobri909/MGBox/DemoAppScreenshot.png)

## Setup

Add the MGBox folder to your project.

## Example Usage

### Create a Scroll Container:

```objc
MGScrollView *scroller = [[MGScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460];
[self.view addSubview:scroller];
```

### Add a Box to the Scroll Container:

```objc
MGStyledBox *box = [MGStyledBox box];
[scroller.boxes addObject:box];
```

### Add Some Lines to the Box:

```objc

// a header line
MGBoxLine *header = [MGBoxLine lineWithLeft:@"My First Box" right:nil];
header.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
[box.topLines addObject:header];

// a string on the left and a horse on the right
UIImage *horse = [UIImage imageNamed:@"horse"];
MGBoxLine *line1 = [MGBoxLine lineWithLeft:@"A string on the left" right:horse];
[box.topLines addObject:line1];
```

### Add a Box with Multiline Text:

```objc

// create a second box
MGStyledBox *box2 = [MGStyledBox box];
[scroller.boxes addObject:box2];

// add a line with multiline text
NSString *blah = @"Multiline content is automatically sized and formatted "
            "given an NSString, UIFont, and desired padding.";
MGBoxLine *multiline = [MGBoxLine multilineWithText:blah font:nil padding:24];
[box2.topLines addObject:multiline];
```

### Tell the Scroll Container to Draw It All To Screen:

```objc
[scroller drawBoxesWithSpeed:0.6];
```

## Enable the Optional Box Edge Snapping

You might like it for your project, or it might annoy you. It's one of those things.

### When You Make the Scroll Container:

```objc
scroller.delegate = self;
```

### In Your ViewController.h:

Own up to being a `UIScrollViewDelegate`

```objc
@interface ViewController : UIViewController <UIScrollViewDelegate>
```

### In Your ViewController.m:

```objc
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [(MGScrollView *)scrollView snapToNearestBox];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [(MGScrollView *)scrollView snapToNearestBox];
    }
}
```

## Tweet a Screenshot of Your Sexy Box

```objc
UIImage *screenshot = [box1 screenshot:0]; // 0 = device scale, 1 = old school, 2 = retina

// tweet it
TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
[tweet setInitialText:@"Check out my box!"];
[tweet addImage:screenshot];
tweet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
    [self dismissModalViewControllerAnimated:YES];
};
[self presentModalViewController:tweet animated:YES];
```

## More Bits and Pieces

### MGBoxLine

Some useful properties to avoid getting your hands too dirty.

#### Line Underlines
```objc
// MGUnderlineNone, MGUnderlineTop or MGUnderlineBottom
line.underlineType = MGUnderlineTop; 
```

#### Line Content Side Precedence

For deciding whether content on the right or left takes precedence when space runs out. `UILabels` will be shortened to fit. `UIImages` and `UIViews` will be removed from the centre outwards, if there's not enough room to fit them in.

```objc
// MGSidePrecedenceLeft or MGSidePrecedenceRight
line.sidePrecedence = MGSidePrecedenceRight;
```

#### Line Content Font Styling

```objc
line.font      = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
line.rightFont = [UIFont fontWithName:@"HelveticaNeue" size:16];
line.textColor = [UIColor colorWithWhite:0.8 alpha:1];
```

#### Line Item Padding

Fine tuning of lines with multiple elements.

```objc
line.linePadding = 3.0;
line.itemPadding = 2.0;
```
