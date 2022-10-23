
#import "BQLeftSideController.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "BQUserInfoViewModel.h"
#import "BQNetwork.h"
#import "BQGeneralMacro.h"
#import "BQUserInfoModel.h"
#import <Toast/Toast.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "UIColor+RGBA.h"

@interface BQLeftSideController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIView *emptyView;
@property(nonatomic, strong)UIView *rightView;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *friendNumLabel;
@property(nonatomic, strong)UILabel *communityNumLabel;
@property(nonatomic, strong)UIImageView *avatarImageView;
@property(nonatomic, strong)BQUserInfoViewModel *userViewModel;

@property(nonatomic, copy)NSArray *dataArray;

@end

@implementation BQLeftSideController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSwipeGesture];
    [self setupDataModel];
    [self setupUI];
}

- (void)setupDataModel {
    self.userViewModel = [BQUserInfoViewModel new];
    NSArray* dataArray1 = @[@{@"icon": @"icon_build_community", @"title": @"创建社区"},@{@"icon": @"icon_discover_profile", @"title": @"探索社区"}];
    NSArray* dataArray2 = @[@{@"icon": @"icon_profile_main", @"title": @"首页"},@{@"icon": @"icon_profile_verify", @"title": @"身份认证"},@{@"icon": @"icon_profile_feedback", @"title": @"产品功能反馈"},@{@"icon": @"icon_profile_notify", @"title": @"通知"},@{@"icon": @"icon_profile_settings", @"title": @"设置"}];
    self.dataArray = @[dataArray1, dataArray2];
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.emptyView = [UIView new];
    self.rightView = [UIView new];
    self.rightView.backgroundColor = [UIColor clearColor];
    self.emptyView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    self.emptyView.alpha = 0.4;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.emptyView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.rightView];
    self.emptyView.frame = self.view.bounds;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    self.rightView.frame = CGRectMake(SCREEN_WIDTH - 86, 0, 86, SCREEN_HEIGHT);
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 86, SCREEN_HEIGHT);
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 86, 184 + 112)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 86, 184)];
    [imageView setImage:[UIImage imageNamed:@"profile_header"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 88, 78, 78)];
    avatarImageView.layer.cornerRadius = 39;
    avatarImageView.clipsToBounds = YES;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(114, 95, SCREEN_WIDTH - 86 - 114 - 16, 26)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [headerView addSubview:imageView];
    [headerView addSubview:avatarImageView];
    [headerView addSubview:nameLabel];
    self.avatarImageView = avatarImageView;
    self.nameLabel = nameLabel;
    CGFloat width = (SCREEN_WIDTH - 86 - 44 - 25) / 2.0;
    UIView *friendView = [[UIView alloc] initWithFrame:CGRectMake(22, 206, width, 69)];
    
    UIView *communityView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 86 - 22 - width, 206, width, 69)];
    [headerView addSubview:friendView];
    [headerView addSubview:communityView];
    friendView.backgroundColor = [UIColor whiteColor];
    communityView.backgroundColor = [UIColor whiteColor];
    friendView.layer.cornerRadius = 8;
    friendView.layer.shadowColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    friendView.layer.shadowOffset = CGSizeMake(0, 0);
    friendView.layer.shadowOpacity = 1;
    friendView.layer.shadowRadius = 4;
    
    communityView.layer.cornerRadius = 8;
    communityView.layer.shadowColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    communityView.layer.shadowOffset = CGSizeMake(0, 0);
    communityView.layer.shadowOpacity = 1;
    communityView.layer.shadowRadius = 4;
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 62) / 2.0, (69 - 24) / 2, 24, 24)];
    [friendView addSubview:iconImageView];
    [iconImageView setImage:[UIImage imageNamed:@"icon_friend"]];
    UILabel *friendNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width + iconImageView.frame.origin.x, 16, 29 + 16, 20)];
    UILabel *friendUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width + iconImageView.frame.origin.x, 69 - 16 - 20, 29 + 16, 20)];
    [friendView addSubview:friendNumLabel];
    [friendView addSubview:friendUnitLabel];
    friendNumLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    friendNumLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    friendUnitLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    friendUnitLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    friendUnitLabel.text = @"伙伴";
    self.friendNumLabel = friendNumLabel;
    friendNumLabel.textAlignment = NSTextAlignmentCenter;
    friendUnitLabel.textAlignment = NSTextAlignmentCenter;
    UIImageView *communityImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 62) / 2.0, (69 - 32) / 2, 32, 32)];
    [communityImageView setImage:[UIImage imageNamed:@"icon_community"]];
    [communityView addSubview:communityImageView];
    UILabel *communityNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width + iconImageView.frame.origin.x, 16, 29 + 16, 20)];
    UILabel *communityUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width + iconImageView.frame.origin.x, 69 - 16 - 20, 29 + 16, 20)];
    [communityView addSubview:communityNumLabel];
    [communityView addSubview:communityUnitLabel];
    communityNumLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    communityNumLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    communityUnitLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    communityUnitLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    communityUnitLabel.text = @"社区";
    self.communityNumLabel = communityNumLabel;
    communityUnitLabel.textAlignment = NSTextAlignmentCenter;
    communityNumLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.rightView addGestureRecognizer:tap];
}

- (void)loadData {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userViewModel.userInfo.profile_img]];
    self.nameLabel.text = self.userViewModel.userInfo.username;
    self.friendNumLabel.text = [NSString stringWithFormat:@"%lu",self.userViewModel.userInfo.friends_num];
    self.communityNumLabel.text = [NSString stringWithFormat:@"%lu",self.userViewModel.userInfo.communities_num];
    [self.tableView reloadData];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.emptyView.alpha = 0;
        self.tableView.frame = CGRectMake(-(SCREEN_WIDTH - 86), 0, SCREEN_WIDTH - 86, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        self.emptyView.alpha = 0.4;
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 86, SCREEN_HEIGHT);
        if (self.sideMenuBlock) {
            self.sideMenuBlock();
        }
    }];
    
}

- (void)setupData {
    WS
    [self.userViewModel getUserInfoSuccess:^(void) {
        SS
        [self loadData];
    } failure:^(NSString * _Nonnull error) {
        SS
        [self.view makeToast:error];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 18;
    } else {
        return 60;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
    if (section == 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 100, 18)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.3];
        titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        titleLabel.text = @"社区相关";
        [header addSubview:titleLabel];
    } else {
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(22, 12, SCREEN_WIDTH - 86 - 44, 1)];
        border.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.1];
        [header addSubview:border];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 42, 100, 18)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.3];
        titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        titleLabel.text = @"服务中心";
        [header addSubview:titleLabel];
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = self.dataArray[section];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *kUserCellIdentifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUserCellIdentifier];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 0, 37, 37)];
        [cell.contentView addSubview:imageView];
        imageView.tag = 1;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 0, 100, 37)];
        [cell.contentView addSubview:textLabel];
        textLabel.tag = 2;
        textLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
        textLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    }
    UIImageView *imageView = [cell viewWithTag:1];
    UILabel *textLabel = [cell viewWithTag:2];
    NSArray *list = self.dataArray[indexPath.section];
    NSDictionary *dict = list[indexPath.row];
    [imageView setImage:[UIImage imageNamed:dict[@"icon"]]];
    textLabel.text = dict[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SwipeGesture

- (void)configSwipeGesture {
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    swipeUp.numberOfTouchesRequired = 1;
    swipeUp.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeUp];
}

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [self tapAction:nil];
}

@end
