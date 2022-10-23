//
//  BQPostModel.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQPostModel.h"

@implementation BQPostModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"images" : [BQPostImageModel class],
             @"comments" : [BQPostCommentModel class]
    };
}

@end
