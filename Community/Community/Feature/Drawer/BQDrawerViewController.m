//
//  BQDrawerViewController.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/14.
//

#import "BQLeftSideController.h"
#import "BQTabBarController.h"
#import "BQDrawerViewController.h"
#import "BQGeneralMacro.h"

@interface BQDrawerViewController ()
@property (nonatomic,strong,readwrite) BQTabBarController *mainController;
@property (nonatomic,strong) BQLeftSideController *leftSideController;
@end

@implementation BQDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addControllers];
    // Do any additional setup after loading the view.
}

- (void)addControllers {
    self.leftSideController = [BQLeftSideController new];
    self.mainController = [BQTabBarController new];
    WS
    self.mainController.sideMenuBlock = ^{
        [UIView animateWithDuration:0.3 animations:^{
            SS
            self.leftSideController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    };
    self.leftSideController.sideMenuBlock = ^{
        SS
        self.leftSideController.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    };
    [self addChildViewController:self.leftSideController];
    [self addChildViewController:self.mainController];
    [self.view addSubview:self.mainController.view];
    [self.view addSubview:self.leftSideController.view];
    self.mainController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.leftSideController.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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
