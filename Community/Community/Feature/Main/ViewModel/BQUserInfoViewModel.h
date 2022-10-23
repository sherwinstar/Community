//
//  BQUserInfoViewModel.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import <Foundation/Foundation.h>

@class BQUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface BQUserInfoViewModel : NSObject

@property (nonatomic, strong, readonly) BQUserInfoModel *userInfo;

-(void)getUserInfoSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure;
@end

NS_ASSUME_NONNULL_END
