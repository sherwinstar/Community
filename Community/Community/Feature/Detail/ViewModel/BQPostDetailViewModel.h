//
//  BQPostDetailViewModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/16.
//

#import <Foundation/Foundation.h>
#import "BQPostModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQPostDetailViewModel : NSObject
@property(nonatomic, strong)BQPostModel *post;
-(CGFloat)getHeaderHeight;
-(CGFloat)getCellHeight:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
