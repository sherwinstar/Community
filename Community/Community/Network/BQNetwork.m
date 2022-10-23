//
//  BQNetwork.m
//

#import "BQNetwork.h"
#import "BQGeneralMacro.h"

const static NSString *baseURL = @"https://console-mock.apipost.cn/app/mock/project/329a5d1d-9d21-4891-dc67-c8f476a5658d";

@implementation BQNetwork

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSString *error))failure{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSURLSessionDataTask *dataTask = [[AFHTTPSessionManager manager] GET:[self getUrl:URLString] parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error.description);
        }
    }];
    
    [dataTask resume];
    return dataTask;
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSString *error))failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask *dataTask = [[AFHTTPSessionManager manager] POST:[self getUrl:URLString] parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error.description);
        }
    }];
    
    [dataTask resume];
    return dataTask;
}

- (NSString *)getUrl:(NSString *)url {
    if (url.length) {
        return [NSString stringWithFormat:@"%@/%@", baseURL, url];
    } else {
        return (NSString *)baseURL;
    }
}

- (void) handleResponse:(NSDictionary *)responseObject success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSString *error))failure {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSInteger code = [[responseObject objectForKey:@"code"] intValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        NSDictionary* data = [responseObject objectForKey:@"data"];
        if (code == 200) {
            SafeBlockRun(success, data)
        } else {
            SafeBlockRun(failure, message)
        }
    }
}

@end
