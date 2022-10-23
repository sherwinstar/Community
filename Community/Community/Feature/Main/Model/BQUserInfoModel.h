//
//  BQUserInfoModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQUserInfoModel : NSObject
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) NSUInteger communities_num;
@property (nonatomic, assign) NSUInteger friends_num;
@property (nonatomic, copy) NSString *profile_img;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
