//
//  BQTabBarController.m
//

#import "BQTabBarController.h"
#import "UIColor+RGBA.h"
#import "BQViewController.h"
#import "BQMainViewController.h"
#import "BQNavigationController.h"
#import "BQDrawerViewController.h"

@interface BQTabBarController ()
@property(nonatomic, strong)BQMainViewController *mainController;
@property (nonatomic,strong) UIButton *plusButton;
@end

@implementation BQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (@available(iOS 13.0, *)) {
//        // iOS13 及以上
//       //选中颜色
        self.tabBar.tintColor = [UIColor colorWithRGB:0x4563F8];
       //默认颜色
        self.tabBar.unselectedItemTintColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
//     }
//    else {
//       // iOS13 以下
       UITabBarItem *item = [UITabBarItem appearance];
       [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRGB:0x000000 alpha:0.6]} forState:UIControlStateNormal];
       [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRGB:0x4563F8]} forState:UIControlStateSelected];
//     }
    
    self.tabBar.backgroundColor = [UIColor colorWithRGB:0xFBFBFB];
    self.tabBar.layer.shadowColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.tabBar.layer.shadowRadius = 8;
    [self setupControllers];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"icon_plus"] selectedImage:[UIImage imageNamed:@"icon_plus"]];
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage {
    self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plusButton addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    self.plusButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    self.plusButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [self.plusButton setImage:buttonImage forState:UIControlStateNormal];
    [self.plusButton setImage:selectedImage forState:UIControlStateSelected];
    
    self.plusButton.adjustsImageWhenHighlighted=NO;
    CGPoint center = self.tabBar.center;
    if (isIPhoneXSeries) {
        center.y = center.y - 60;
    } else {
        center.y = center.y - 25;
    }

    self.plusButton.center = center;
    [self.view addSubview:self.plusButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.plusButton];
}

- (void)showCenterButton {
    self.plusButton.alpha = 0;
    [self.view bringSubviewToFront:self.plusButton];
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = self.plusButton.center;
        if (center.x < 0) {
            center.x = SCREEN_WIDTH / 2.0;
        }
        self.plusButton.alpha = 1;
        self.plusButton.center = center;
    } completion:^(BOOL finished) {
        [self.view addSubview:self.plusButton];
    }];
}

- (void)hideCenterButton {
    self.plusButton.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = self.plusButton.center;
        if (center.x > 0) {
            center.x = -50;
        }
        self.plusButton.alpha = 0;
        self.plusButton.center = center;
    }];
}

-(void)pressChange:(id)sender {
    self.selectedIndex = 2;
    self.plusButton.selected = YES;
}

- (void)setupControllers {
    BQMainViewController *mainController = [BQMainViewController new];
    self.mainController = mainController;
    BQNavigationController* mainNaviController = [[BQNavigationController alloc] initWithRootViewController:mainController];
    mainController.sideMenuBlock = self.sideMenuBlock;
    mainNaviController.tabBarItem.title = @"首页";
    mainNaviController.tabBarItem.image = [UIImage imageNamed:@"icon_tab_home"];
    UIImage *selectedImage = [[UIImage imageNamed:@"icon_tab_home"] imageWithTintColor:[UIColor colorWithRGB:0x4563F8] renderingMode:UIImageRenderingModeAlwaysTemplate];
    mainNaviController.tabBarItem.selectedImage = selectedImage;
    
    UIViewController *messageController = [BQViewController new];
    messageController.tabBarItem.title = @"探索";
    messageController.tabBarItem.image = [UIImage imageNamed:@"icon_tab_discover"];
    messageController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_discover"];
    
    UIViewController *testController = [BQViewController new];
    testController.tabBarItem.title = @"";
    testController.tabBarItem.image = [UIImage imageNamed:@"tab_mine_unselected"];
    testController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_mine_selected"];

    UIViewController *mineController = [BQViewController new];
    mineController.tabBarItem.title = @"聊天";
    mineController.tabBarItem.image = [UIImage imageNamed:@"icon_tab_message"];
    mineController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_message"];
    UIViewController *notificationController = [BQViewController new];
    notificationController.tabBarItem.title = @"通知";
    notificationController.tabBarItem.image = [UIImage imageNamed:@"icon_tab_notification"];
    notificationController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_notification"];
    self.viewControllers = @[mainNaviController,messageController, testController, mineController, notificationController];
}

-(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

- (void)setSideMenuBlock:(BQShowSideMenuBlock)sideMenuBlock {
    _sideMenuBlock = sideMenuBlock;
    self.mainController.sideMenuBlock = sideMenuBlock;
}

+ (BQTabBarController *)sharedTabBarController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *rootViewController = [window rootViewController];
    if ([rootViewController isKindOfClass:[BQDrawerViewController class]]) {
        BQDrawerViewController *controller = (BQDrawerViewController*)rootViewController;
        return controller.mainController;
    }
    return nil;
}

@end
