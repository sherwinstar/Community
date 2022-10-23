//
//  HCViewController.m
//  HIPC
//
//  Created by Shaolin Zhou on 2022/4/19.
//

#import "BQViewController.h"
#import "UIColor+RGBA.h"

@interface BQViewController ()

@end

@implementation BQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRGB:0xF6F6F6];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    // Do any additional setup after loading the view.
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
