//
//  AppDelegate.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/14.
//

#import "AppDelegate.h"
#import "BQTabBarController.h"
#import "BQLeftSideController.h"
#import "BQNavigationController.h"
#import "BQDrawerViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) BQDrawerViewController *drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1、初始化控制器
    
    self.drawerController = [BQDrawerViewController new];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

@end
