//
//  BQPostCell.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <UIKit/UIKit.h>

@class BQPostModel;

NS_ASSUME_NONNULL_BEGIN

@interface BQPostCell : UITableViewCell
- (void)updateData:(BQPostModel *)model;
@end

NS_ASSUME_NONNULL_END
