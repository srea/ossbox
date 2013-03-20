@class MGBox;

@interface OSSDetailViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSDictionary  *detailItem;
- (MGBox *)parentBoxOf:(UIView *)view;

@end
