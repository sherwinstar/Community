//
//  BQDrawerViewController.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/14.
//

#import "BQViewController.h"
#import "BQTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQDrawerViewController : BQViewController
@property (nonatomic,strong, readonly) BQTabBarController *mainController;
@end

NS_ASSUME_NONNULL_END
