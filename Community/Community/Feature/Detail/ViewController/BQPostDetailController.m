//
//  BQPostDetailViewController.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQPostDetailController.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "UIColor+RGBA.h"
#import "UIView+Size.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BQPostCommentCell.h"
#import "BQPostDetailHeader.h"
#import "BQPostDetailViewModel.h"
#import "BQTabBarController.h"

@interface BQPostDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)BQPostModel *post;
@property(nonatomic, strong)BQPostDetailViewModel *detailViewModel;
@end

@implementation BQPostDetailController

- (instancetype)initWithPost:(BQPostModel *)post {
    if (self = [super init]) {
        self.post = post;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailViewModel = [BQPostDetailViewModel new];
    self.detailViewModel.post = self.post;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:BQPostCommentCell.class forCellReuseIdentifier:@"BQPostCommentCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-51 - IPHONEX_SAFEAREA);
    }];
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 51 - IPHONEX_SAFEAREA, SCREEN_WIDTH, 51 + IPHONEX_SAFEAREA)];
    [self.view addSubview:commentView];
    commentView.backgroundColor = [UIColor whiteColor];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(51 + IPHONEX_SAFEAREA));
    }];
    commentView.layer.borderWidth = 1;
    commentView.layer.borderColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    UIImageView *imageView = [UIImageView new];
    [commentView addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"icon_comment_input"]];
    imageView.layer.cornerRadius = 19.5;
    imageView.clipsToBounds = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentView).offset(24);
        make.top.equalTo(commentView).offset(11);
        make.width.height.equalTo(@(39));
    }];
    UITextField *textField = [UITextField new];
    [commentView addSubview:textField];
    textField.placeholder = @"添加评论";
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderWidth = 1;
    textField.font = [UIFont systemFontOfSize:14];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    textField.layer.cornerRadius = 19.5;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(12);
        make.top.equalTo(commentView).offset(11);
        make.right.equalTo(commentView).offset(-24);
        make.height.equalTo(@(39));
    }];
    BQPostDetailHeader *tableHeaderView = [[BQPostDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self.detailViewModel getHeaderHeight])];
    [tableHeaderView updateData:self.post];
    self.tableView.tableHeaderView = tableHeaderView;
    if (self.post.comments.count == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 169 + 9 + 20)];
        UIImageView *emptyView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 171) / 2.0, 9, 171, 169)];
        [emptyView setImage:[UIImage imageNamed:@"icon_empty"]];
        [footerView addSubview:emptyView];
        self.tableView.tableFooterView = footerView;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit:)]];
}

- (void)endEdit:(id)sender {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.post.comments.count > 0 ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 8, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    titleLabel.text = [NSString stringWithFormat:@"共%lu条评论", self.post.comments.count];
    [header addSubview:titleLabel];
    return header;
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [[BQTabBarController sharedTabBarController] showCenterButton];
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footer = [UIView new];
//    footer.backgroundColor = [UIColor colorWithRGB:0xFFFFFF];
//    return footer;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.post.comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.detailViewModel getCellHeight:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kItemCellID = @"BQPostCommentCell";
    if (indexPath.row < self.post.comments.count) {
        BQPostCommentCell *cell = (BQPostCommentCell *)[tableView dequeueReusableCellWithIdentifier:kItemCellID forIndexPath:indexPath];
        BQPostCommentModel *model = self.post.comments[indexPath.row];
        [cell updateData:model isLast:indexPath.row == self.post.comments.count - 1];
        return cell;
    }
    return [UITableViewCell new];
}

@end
