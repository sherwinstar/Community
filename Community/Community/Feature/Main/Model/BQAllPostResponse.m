//
//  BQAllPostResponse.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQAllPostResponse.h"
#import "BQPostModel.h"

@implementation BQAllPostResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"posts" : [BQPostModel class]};
}
@end
