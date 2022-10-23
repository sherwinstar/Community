//
//  BQPostModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
#import "BQPostCommentModel.h"
#import "BQPostImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BQPostModel : NSObject
@property (nonatomic, assign) long long collections;
@property (nonatomic, copy) NSString *profile_img;
@property (nonatomic, copy) NSString *community;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, assign) long long reads;
@property (nonatomic, copy) NSString *sender_name;
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL collected;
@end

NS_ASSUME_NONNULL_END
