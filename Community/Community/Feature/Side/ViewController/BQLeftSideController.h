

#import "BQViewController.h"

typedef void(^BQHideSideMenuBlock)(void);

@interface BQLeftSideController : BQViewController
@property(nonatomic, copy) BQHideSideMenuBlock sideMenuBlock;
@end
