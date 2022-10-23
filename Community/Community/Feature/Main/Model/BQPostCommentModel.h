//
//  BQPostCommentModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQPostCommentModel : NSObject
@property (nonatomic, assign) long long likes;
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
