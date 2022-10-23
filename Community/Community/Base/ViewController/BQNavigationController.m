//
//  HCNavigationController.m
//  HIPC
//
//  Created by Shaolin Zhou on 2022/5/8.
//

#import "BQNavigationController.h"
#import "UIColor+RGBA.h"

@interface BQNavigationController ()

@end

@implementation BQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *navigationBarAppearance = [UINavigationBarAppearance new];
        UIImage *image = [[UIColor colorWithRGB:0xFFFFFF] colorToImage];
        [navigationBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRGB:0x000000 alpha:0.8], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium]}];
        [navigationBarAppearance setBackgroundImage:image];
        navigationBarAppearance.shadowColor = [UIColor colorWithRGB:0xFFFFFF];
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance;
        self.navigationBar.standardAppearance = navigationBarAppearance;
    } else {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRGB:0x000000 alpha:0.8], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
        [self.navigationBar setTranslucent:NO];
        [self.navigationBar setBackgroundImage:[[UIColor colorWithRGB:0xFFFFFF] colorToImage] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.layer.shadowColor = [UIColor colorWithRGB:0x000000 alpha:0.25].CGColor;
        [self.navigationBar setShadowImage:[UIImage new]];
        self.navigationBar.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
