//
//  BQPostDetailViewController.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQViewController.h"
#import "BQPostModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQPostDetailController : BQViewController
- (instancetype)initWithPost:(BQPostModel *)post;
@end

NS_ASSUME_NONNULL_END
