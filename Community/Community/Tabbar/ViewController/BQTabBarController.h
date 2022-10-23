//
//  BQTabBarController.h
//

#import <UIKit/UIKit.h>
#import "BQMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQTabBarController : UITabBarController

@property(nonatomic, copy) BQShowSideMenuBlock sideMenuBlock;

+ (BQTabBarController *)sharedTabBarController;
- (void)showCenterButton;

- (void)hideCenterButton;

@end

NS_ASSUME_NONNULL_END
