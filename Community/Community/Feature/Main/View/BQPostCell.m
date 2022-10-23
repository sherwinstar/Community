//
//  BQPostCell.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQPostCell.h"
#import "BQPostModel.h"
#import "UIColor+RGBA.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "UIView+Size.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BQPostCell ()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *comunityLabel;
@property(nonatomic, strong) UILabel *readLabel;
@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIView *imageHostView;
@property(nonatomic, strong) UIButton *indicatorButton;
@property(nonatomic, strong) UIButton *msgButton;
@property(nonatomic, strong) UIButton *swapButton;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UILabel *collectionLabel;
@property(nonatomic, strong) BQPostModel *post;
@end

@implementation BQPostCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 8;
    
    _bgView.layer.shadowColor = [UIColor colorWithRGB:0x000000 alpha:0.1].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0, 0);
    _bgView.layer.shadowOpacity = 1;
    _bgView.layer.shadowRadius = 4;
    [self.contentView addSubview:_bgView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.top.equalTo(self).offset(8);
        make.bottom.equalTo(self).offset(-8);
    }];
    _avatarImageView = [UIImageView new];
    [_bgView addSubview:_avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@36);
        make.height.equalTo(@36);
        make.top.equalTo(self.bgView).offset(16);
        make.left.equalTo(self.bgView).offset(16);
    }];
    self.avatarImageView.layer.cornerRadius = 18;
    self.avatarImageView.clipsToBounds = YES;
    _nameLabel = [UILabel new];
    [_bgView addSubview:_nameLabel];
    self.nameLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    _readLabel = [UILabel new];
    [_bgView addSubview:_readLabel];
    self.readLabel.layer.cornerRadius = 9;
    self.readLabel.backgroundColor = [UIColor colorWithRGB:0xF5F5F5];
    self.readLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.readLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    self.readLabel.layer.borderColor = [UIColor colorWithRGB:0xF5F5F5].CGColor;
    self.readLabel.layer.borderWidth = 1;
    self.readLabel.clipsToBounds = YES;
    self.readLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.top.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-16);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        make.top.equalTo(self.bgView).offset(16);
        make.left.equalTo(self.bgView).offset(62);
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
//        make.width.equalTo(@47);
        make.top.equalTo(self.bgView).offset(36);
        make.left.equalTo(self.bgView).offset(62);
    }];
    _comunityLabel.textAlignment = NSTextAlignmentLeft;
    [_comunityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.height.equalTo(@17);
        make.top.equalTo(self.bgView).offset(36);
        make.left.equalTo(self.timeLabel.mas_right).offset(19).priorityHigh();
    }];

    _contentLabel = [UILabel new];
    [_bgView addSubview:_contentLabel];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 2;
    self.contentLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.height.equalTo(@20);
        make.top.equalTo(self.bgView).offset(67);
        make.left.equalTo(self.bgView).offset(16);
    }];
    _imageHostView = [UIView new];
    [_bgView addSubview:_imageHostView];
    [_imageHostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(-50);
        make.height.equalTo(@80);
        make.right.equalTo(self.bgView).offset(-16);
        make.left.equalTo(self.bgView).offset(16);
    }];
    _imageHostView.hidden = YES;
    _indicatorButton = [UIButton new];
    [_bgView addSubview:_indicatorButton];
    [_indicatorButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    _indicatorButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_indicatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@12);
        make.height.equalTo(@16);
        make.bottom.equalTo(self.bgView).offset(-17);
        make.left.equalTo(self.bgView).offset(16);
    }];
    _msgButton = [UIButton new];
    [_bgView addSubview:_msgButton];
    
    [_msgButton setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
    _msgButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_msgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@17);
        make.height.equalTo(@17);
        make.bottom.equalTo(self.bgView).offset(-16.5);
        make.left.equalTo(self.bgView).offset(48);
    }];
    _swapButton = [UIButton new];
    [_bgView addSubview:_swapButton];
    [_swapButton setImage:[UIImage imageNamed:@"icon_forward"]forState:UIControlStateNormal];
    _swapButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_swapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@17);
        make.height.equalTo(@17);
        make.bottom.equalTo(self.bgView).offset(-17);
        make.left.equalTo(self.bgView).offset(85);
    }];
    _commentLabel = [UILabel new];
    [_bgView addSubview:_commentLabel];
    _collectionLabel = [UILabel new];
    [_bgView addSubview:_collectionLabel];
    [_collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.bottom.equalTo(self.bgView).offset(-16);
        make.right.equalTo(self.bgView).offset(-16);
    }];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.collectionLabel.mas_left).offset(-19);
        make.height.equalTo(@18);
        make.bottom.equalTo(self.bgView).offset(-16);
    }];
    self.commentLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.commentLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.collectionLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.collectionLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
}

- (void)updateData:(BQPostModel *)model {
    self.post = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_img] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    self.nameLabel.text = model.sender_name;
    self.comunityLabel.text = [NSString stringWithFormat:@"发表于【%@】", model.community];
    self.timeLabel.text = model.createdAt;
    self.commentLabel.text = [NSString stringWithFormat:@"%lu 评论", (unsigned long)model.comments.count];
    self.collectionLabel.text = [NSString stringWithFormat:@"%lld 收藏", model.collections];
    self.readLabel.text = [NSString stringWithFormat:@"%lld 阅读", model.reads];
    CGSize sizeThatFits = [self.readLabel sizeThatFits:CGSizeMake(150, 18)];
    [self.readLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(sizeThatFits.width + 10));
    }];
    self.contentLabel.text = model.content;
    CGSize sizeThatFits2 = [self.contentLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - 80, 40)];
    CGFloat contentHeight = 20;
    if (sizeThatFits2.height > 20) {
        contentHeight = 40;
    }
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(contentHeight));
    }];
    if (model.images.count > 0) {
        _imageHostView.hidden = NO;
        [self addImages:model];
    } else {
        _imageHostView.hidden = YES;
    }
}

- (void)addImages:(BQPostModel *)model {
    for (UIView *view in _imageHostView.subviews) {
        [view removeFromSuperview];
    }
    NSUInteger imageCount = (SCREEN_WIDTH - 80 + 8) / 88.0;
    CGFloat offset = 0;
    NSUInteger index = 0;
    UIImageView *imageView = nil;
    for (; index < imageCount && index < model.images.count; index++) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(offset, 0, 80, 80)];
        BQPostImageModel *imageModel = model.images[index];
        [_imageHostView addSubview:imageView];
        imageView.layer.cornerRadius = 6;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"icon_default"]];
        offset += 88;
    }
    if (index < model.images.count) {
        UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80 - 20, 80, 16)];
        moreLabel.textColor = UIColor.whiteColor;
        moreLabel.text = [NSString stringWithFormat:@"还有%lu张",model.images.count - index];
        moreLabel.font = [UIFont systemFontOfSize:12];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:moreLabel];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
