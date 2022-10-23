//
//  BQPostDetailHeader.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import "BQPostDetailHeader.h"
#import "UIColor+RGBA.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "UIView+Size.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BQPostModel.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface BQPostDetailHeader ()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *comunityLabel;
@property(nonatomic, strong) UILabel *readLabel;
@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIView *imageHostView;
@property(nonatomic, strong) UIButton *collectionButton;
@property(nonatomic, strong) UIButton *swapButton;
@property(nonatomic, strong) UILabel *forwardLabel;
@property(nonatomic, strong) UILabel *collectionLabel;

@property(nonatomic, strong)BQPostModel *post;
@end

@implementation BQPostDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 8;
    [self addSubview:_bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.top.equalTo(self).offset(27);
        make.bottom.equalTo(self).offset(-24);
    }];
    
    UIView *border = [UIView new];
    border.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.1];
    [self addSubview:border];
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self).offset(-8);
    }];
    
    _avatarImageView = [UIImageView new];
    [_bgView addSubview:_avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
    }];
    self.avatarImageView.layer.cornerRadius = 30;
    self.avatarImageView.clipsToBounds = YES;
    _nameLabel = [UILabel new];
    [_bgView addSubview:_nameLabel];
    self.nameLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    _readLabel = [UILabel new];
    [_bgView addSubview:_readLabel];
    self.readLabel.layer.cornerRadius = 9.5;
    self.readLabel.backgroundColor = [UIColor colorWithRGB:0xF5F5F5];
    self.readLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.readLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    self.readLabel.layer.borderColor = [UIColor colorWithRGB:0xF5F5F5].CGColor;
    self.readLabel.layer.borderWidth = 1;
    self.readLabel.clipsToBounds = YES;
    self.readLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.top.equalTo(self.bgView).offset(0);
        make.right.equalTo(self.bgView).offset(-5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        make.top.equalTo(self.bgView).offset(11);
        make.left.equalTo(self.bgView).offset(70);
    }];
    _comunityLabel = [UILabel new];
    [_bgView addSubview:_comunityLabel];
    _timeLabel = [UILabel new];
    [_bgView addSubview:_timeLabel];
    self.comunityLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.comunityLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    self.timeLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.timeLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.top.equalTo(self.bgView).offset(31);
        make.left.equalTo(self.bgView).offset(70);
    }];
    _comunityLabel.textAlignment = NSTextAlignmentLeft;
    [_comunityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.height.equalTo(@17);
        make.top.equalTo(self.bgView).offset(31);
        make.left.equalTo(self.timeLabel.mas_right).offset(19).priorityHigh();
    }];

    _contentLabel = [UILabel new];
    [_bgView addSubview:_contentLabel];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.contentLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.right.equalTo(self.bgView).offset(0);
        make.top.equalTo(self.bgView).offset(76);
        make.left.equalTo(self.bgView).offset(0);
    }];
    _imageHostView = [UIView new];
    _imageHostView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_imageHostView];
    [_imageHostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(-42);
        make.height.equalTo(@110);
        make.right.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
    }];
    _imageHostView.hidden = YES;
    _collectionButton = [UIButton new];
    [_bgView addSubview:_collectionButton];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    _collectionButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@12);
        make.height.equalTo(@16);
        make.bottom.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
    }];

    _swapButton = [UIButton new];
    [_bgView addSubview:_swapButton];
    [_swapButton setImage:[UIImage imageNamed:@"icon_forward"]forState:UIControlStateNormal];
    _swapButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_swapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@17);
        make.height.equalTo(@17);
        make.bottom.equalTo(self.bgView).offset(0);
        make.left.equalTo(self.bgView).offset(90);
    }];
    _forwardLabel = [UILabel new];
    [_bgView addSubview:_forwardLabel];
    _collectionLabel = [UILabel new];
    [_bgView addSubview:_collectionLabel];
    [_collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.bottom.equalTo(self.bgView.mas_bottom);
        make.left.equalTo(self.bgView).offset(24);
    }];
    [_forwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(118);
        make.height.equalTo(@18);
        make.bottom.equalTo(self.bgView);
    }];
    self.forwardLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.forwardLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.collectionLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.collectionLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
}

- (void)addImages {
    for (UIView *view in _imageHostView.subviews) {
        [view removeFromSuperview];
    }
    NSUInteger imageCount = (SCREEN_WIDTH - 48 + 6) / 116.0;
    CGFloat offset = 0;
    NSUInteger index = 0;
    UIImageView *imageView = nil;
    for (; index < imageCount && index < self.post.images.count; index++) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(offset, 0, 110, 110)];
        BQPostImageModel *imageModel = self.post.images[index];
        [_imageHostView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 4;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"icon_default"]];
        offset += 116;
        imageView.tag = index;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    }
    if (index < self.post.images.count) {
        UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 - 20, 110, 16)];
        moreLabel.textColor = UIColor.whiteColor;
        moreLabel.text = [NSString stringWithFormat:@"还有%lu张",self.post.images.count - index];
        moreLabel.font = [UIFont systemFontOfSize:11];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:moreLabel];
    }
}

- (void)updateData:(BQPostModel *)model {
    self.post = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_img] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    self.nameLabel.text = model.sender_name;
    self.comunityLabel.text = [NSString stringWithFormat:@"发表于【%@】", model.community];
    self.timeLabel.text = model.createdAt;
    self.forwardLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)model.comments.count];
    self.collectionLabel.text = [NSString stringWithFormat:@"%lld", model.collections];
    self.readLabel.text = [NSString stringWithFormat:@"%lld 阅读", model.reads];
    CGSize sizeThatFits = [self.readLabel sizeThatFits:CGSizeMake(150, 18)];
    [self.readLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(sizeThatFits.width + 10));
    }];
    self.contentLabel.text = model.content;
    CGSize sizeThatFits2 = [self.contentLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - 48, CGFLOAT_MAX)];
    CGFloat contentHeight = 20;
    if (sizeThatFits2.height > contentHeight) {
        contentHeight = sizeThatFits2.height + 4;
    }
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(contentHeight));
    }];
    if (model.images.count > 0) {
        _imageHostView.hidden = NO;
        [self addImages];
    } else {
        _imageHostView.hidden = YES;
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = self.post.images.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i< count; i++) {
        // 替换为中等尺寸图片
        BQPostImageModel *model = self.post.images[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:model.url]; // 图片路径
        if (i < _imageHostView.subviews.count) {
            photo.srcImageView = _imageHostView.subviews[i];
        }
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

@end
