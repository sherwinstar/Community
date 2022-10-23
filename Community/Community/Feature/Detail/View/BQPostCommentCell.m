//
//  BQPostCommentCell.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import "BQPostCommentCell.h"
#import "UIColor+RGBA.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"
#import "UIView+Size.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BQPostCommentCell ()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *likeImageView;
@property(nonatomic, strong) UILabel *likeLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UIView *border;
@property(nonatomic, strong) UILabel *contentLabel;
@end

@implementation BQPostCommentCell

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
    [self.contentView addSubview:_bgView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(23);
        make.right.equalTo(self).offset(-23);
        make.top.equalTo(self).offset(8);
        make.bottom.equalTo(self).offset(-8);
    }];
    
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.image = [UIImage imageNamed:@"icon_comment_avatar"];
    [self.bgView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.width.height.equalTo(@40);
        make.centerY.equalTo(self.bgView);
    }];
    _nameLabel = [UILabel new];
    [_bgView addSubview:_nameLabel];
    self.nameLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    _likeImageView = [UIImageView new];
    _likeImageView.image = [UIImage imageNamed:@"icon_like"];
    [self.bgView addSubview:self.likeImageView];
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right);
        make.width.height.equalTo(@16);
        make.height.equalTo(@15);
        make.top.equalTo(self.bgView).offset(4);
    }];
    
    _likeLabel = [UILabel new];
    [_bgView addSubview:_likeLabel];
    self.likeLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.likeLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    self.likeLabel.clipsToBounds = YES;
    self.likeLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.top.equalTo(self.bgView).offset(22);
        make.centerX.equalTo(self.likeImageView);
    }];
    self.likeLabel.text = @"18";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(48);
    }];
    _timeLabel = [UILabel new];
    [_bgView addSubview:_timeLabel];
    self.timeLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    self.timeLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
    }];
    _timeLabel.text = @"8小时前 福建";
    _nameLabel.text = @"若小小乖";
    _contentLabel = [UILabel new];
    [_bgView addSubview:_contentLabel];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 2;
    self.contentLabel.textColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    self.contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-40);
        make.top.equalTo(self.bgView).offset(22);
        make.left.equalTo(self.bgView).offset(48);
    }];
    UIView *border = [UIView new];
    border.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.1];
    [self.contentView addSubview:border];
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(71);
        make.right.equalTo(self);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self);
    }];
    self.border = border;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateData:(BQPostCommentModel *)model isLast:(BOOL)isLast {
    self.contentLabel.text = model.content;
    self.border.hidden = isLast;
}

@end
