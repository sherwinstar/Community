//
//  BQPostCommentCell.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import <UIKit/UIKit.h>
#import "BQPostCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQPostCommentCell : UITableViewCell
- (void)updateData:(BQPostCommentModel *)model isLast:(BOOL)isLast;
@end

NS_ASSUME_NONNULL_END
