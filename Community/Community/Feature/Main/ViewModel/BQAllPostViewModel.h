//
//  BQAllPostViewModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BQAllPostResponse;
@class BQPostModel;

NS_ASSUME_NONNULL_BEGIN

@interface BQAllPostViewModel : NSObject

@property (nonatomic, strong, readonly) BQAllPostResponse *allPost;

-(void)getAllPostListSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure;

-(CGFloat)getCellHeight:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
