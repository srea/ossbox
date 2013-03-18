@class MGBox;

@interface OSSDetailViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray  *detailItem;
- (MGBox *)parentBoxOf:(UIView *)view;

@end
