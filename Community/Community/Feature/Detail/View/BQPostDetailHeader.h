//
//  BQPostDetailHeader.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import <UIKit/UIKit.h>
#import "BQPostModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQPostDetailHeader : UIView

- (void)updateData:(BQPostModel *)model;
@end

NS_ASSUME_NONNULL_END
