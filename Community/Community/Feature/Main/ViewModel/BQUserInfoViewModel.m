//
//  BQUserInfoViewModel.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQUserInfoViewModel.h"
#import "BQNetwork.h"
#import "BQGeneralMacro.h"
#import "BQUserInfoModel.h"

@interface BQUserInfoViewModel ()

@property (nonatomic, strong, readwrite) BQUserInfoModel *userInfo;
@end

@implementation BQUserInfoViewModel

-(void)getUserInfoSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure {
    [[BQNetwork sharedInstance] GET:@"getUserInfo" parameters:nil success:^(NSDictionary * responseObject) {
        BQUserInfoModel *model = [BQUserInfoModel yy_modelWithDictionary:responseObject];
        if (model) {
            self.userInfo = model;
            SafeBlockRun(success);
        } else {
            SafeBlockRun(failure, @"获取数据失败");
        }
    } failure:^(NSString * error) {
        SafeBlockRun(failure, error);
    }];
}

@end
