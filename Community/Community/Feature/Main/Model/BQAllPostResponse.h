//
//  BQAllPostResponse.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQAllPostResponse : NSObject
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSArray *posts;
@end

NS_ASSUME_NONNULL_END
