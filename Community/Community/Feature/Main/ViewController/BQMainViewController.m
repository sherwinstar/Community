//
//  BQMainViewController.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/14.
//

#import "BQMainViewController.h"
#import "UIColor+RGBA.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "BQUserInfoViewModel.h"
#import "BQUserInfoModel.h"
#import "BQAllPostViewModel.h"
#import "BQPostCell.h"
#import "BQAllPostResponse.h"
#import <Toast/Toast.h>
#import "BQPostModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BQPostDetailController.h"
#import "BQTabBarController.h"

@interface BQMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIView *hotView;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UIButton *hotButton;
@property(nonatomic, strong) UIButton *freshButton;
@property(nonatomic, strong) BQUserInfoViewModel *profileViewModel;
@property(nonatomic, strong) BQAllPostViewModel *allPostViewModel;

@property(nonatomic, strong) UIView *avatarView;
@end

@implementation BQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.profileViewModel = [BQUserInfoViewModel new];
    self.allPostViewModel = [BQAllPostViewModel new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createHotView];
    
    [self createTableView];
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    [self configSwipeGesture];
    
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:BQPostCell.class forCellReuseIdentifier:@"BQPostCell"];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    header.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
    self.tableView.tableHeaderView = header;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 18)];
    footer.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
    self.tableView.tableFooterView = footer;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.hotView.mas_bottom);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)createHotView {
    self.hotView = [UIView new];
    self.hotView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hotView];
    [self.hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(162));
        make.height.equalTo(@(40));
        make.left.equalTo(self.view).offset(24);
        make.top.equalTo(self.view);
    }];
    self.hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.hotView addSubview:self.hotButton];
    self.freshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.hotView addSubview:self.freshButton];
    
    self.hotButton.layer.cornerRadius = 14;
    self.freshButton.layer.cornerRadius = 14;
    [self.hotButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    [self.freshButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    
    [self.hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(76));
        make.height.equalTo(@(28));
        make.right.equalTo(self.hotView);
        make.centerY.equalTo(self.hotView);
    }];
    
    [self.freshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(76));
        make.height.equalTo(@(28));
        make.left.equalTo(self.hotView);
        
        make.centerY.equalTo(self.hotView);
    }];
    
    [self.freshButton setTitle:@"最新" forState:UIControlStateNormal];
    [self.hotButton setTitle:@"最热" forState:UIControlStateNormal];
    [self.freshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor colorWithRGB:0x000000 alpha:0.6] forState:UIControlStateNormal];
    [self.freshButton setBackgroundColor:[UIColor colorWithRGB:MainColor]];
    [self.hotButton setBackgroundColor:[UIColor clearColor]];
    [self.freshButton addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.hotButton addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hotAction:(UIButton*)button {
    if (button == self.hotButton) {
        [self.hotButton setBackgroundColor:[UIColor colorWithRGB:MainColor]];
        [self.freshButton setBackgroundColor:[UIColor clearColor]];
        [self.hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.freshButton setTitleColor:[UIColor colorWithRGB:0x000000 alpha:0.6] forState:UIControlStateNormal];
    } else {
        [self.freshButton setBackgroundColor:[UIColor colorWithRGB:MainColor]];
        [self.hotButton setBackgroundColor:[UIColor clearColor]];
        [self.freshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.hotButton setTitleColor:[UIColor colorWithRGB:0x000000 alpha:0.6] forState:UIControlStateNormal];
    }
    WS
    [self.allPostViewModel getAllPostListSuccess:^(void) {
        SS
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull error) {
        SS
        [self.view makeToast:error];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupData {
    WS
    [self.profileViewModel getUserInfoSuccess:^(void) {
        SS
        [self loadAvatar];
    } failure:^(NSString * _Nonnull error) {
        SS
        [self.view makeToast:error];
    }];
    [self.allPostViewModel getAllPostListSuccess:^(void) {
        SS
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull error) {
        SS
        [self.view makeToast:error];
    }];
}

-(void)leftDrawerButtonPress:(id)sender{
    SafeBlockRun(self.sideMenuBlock)
}

-(void)searchButtonPress:(id)sender{
}

-(void)setupLeftMenuButton {
    self.avatarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    imageView.tag = 1;
    [self.avatarView addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 16;
    imageView.clipsToBounds = YES;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.avatarView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.avatarView addGestureRecognizer:tapGesture];
}

- (void)loadAvatar {
    UIImageView *imageView = [self.avatarView viewWithTag:1];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.profileViewModel.userInfo.profile_img]];
}

-(void)setupRightMenuButton {
    self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    self.searchButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.searchButton.clipsToBounds = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchButton];
    [self.searchButton addTarget:self action:@selector(searchButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 2;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 18;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *header = [UIView new];
//    header.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
//    return header;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footer = [UIView new];
//    footer.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
//    return footer;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPostViewModel.allPost.posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.allPostViewModel getCellHeight:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.allPostViewModel.allPost.posts.count) {
        return;
    }
    BQPostModel *model = self.allPostViewModel.allPost.posts[indexPath.row];
    BQPostDetailController *controller = [[BQPostDetailController alloc] initWithPost:model];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [[BQTabBarController sharedTabBarController] hideCenterButton];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kItemCellID = @"BQPostCell";
    if (indexPath.row < self.allPostViewModel.allPost.posts.count) {
        BQPostCell *cell = (BQPostCell *)[tableView dequeueReusableCellWithIdentifier:kItemCellID forIndexPath:indexPath];
        BQPostModel *model = self.allPostViewModel.allPost.posts[indexPath.row];
        [cell updateData:model];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - SwipeGesture

- (void)configSwipeGesture {
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    swipeUp.numberOfTouchesRequired = 1;
    swipeUp.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeUp];
}

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [self leftDrawerButtonPress:nil];
}

@end
