//
//  BQPostDetailViewModel.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import "BQPostDetailViewModel.h"
#import "UIColor+RGBA.h"
#import <Masonry/Masonry.h>
#import "BQGeneralMacro.h"


@implementation BQPostDetailViewModel

-(CGFloat)getHeaderHeight {
    CGRect textRect = [self.post.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 48, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]} context:nil];
    CGFloat height = textRect.size.height + 4;
    CGFloat imageHeight = 0;
    if (self.post.images.count) {
        imageHeight = 120;
    }
    return 76 + height + imageHeight + 58 + 8 + 27;
}

-(CGFloat)getCellHeight:(NSUInteger)index {
    if (index >= self.post.comments.count) {
        return 0;
    }
    BQPostCommentModel *model = self.post.comments[index];
    CGRect textRect = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 71 - 63, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]} context:nil];
    CGFloat height = textRect.size.height + 16 + 4;
    if (height >= 40) {
        height = 40;
    }else if (height <= 20) {
        height = 20;
    }
    return 8 + 22 + height + 8;
}

@end
