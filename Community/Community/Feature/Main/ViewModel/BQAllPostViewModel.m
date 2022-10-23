//
//  BQAllPostViewModel.m
//  Community
//
//  Created by Shaolin Zhou on 2022/9/15.
//

#import "BQAllPostViewModel.h"
#import "BQAllPostResponse.h"
#import "BQNetwork.h"
#import "BQGeneralMacro.h"
#import "BQPostModel.h"

@interface BQAllPostViewModel ()

@property (nonatomic, strong, readwrite) BQAllPostResponse *allPost;
@end

@implementation BQAllPostViewModel

-(void)getAllPostListSuccess:(void (^)(void))success failure:(void (^)(NSString *error))failure {
    [[BQNetwork sharedInstance] GET:@"getAllPostList" parameters:nil success:^(NSDictionary * responseObject) {
        BQAllPostResponse *model = [BQAllPostResponse yy_modelWithDictionary:responseObject];
        if (model) {
            self.allPost = model;
            SafeBlockRun(success);
        } else {
            SafeBlockRun(failure, @"获取数据失败");
        }
    } failure:^(NSString * error) {
        SafeBlockRun(failure, error);
    }];
}

-(CGFloat)getCellHeight:(NSUInteger)index {
    if (index >= self.allPost.posts.count) {
        return 0;
    }
    BQPostModel *model = self.allPost.posts[index];
    CGRect textRect = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]} context:nil];
    CGFloat height = textRect.size.height + 4;
    if (height >= 40) {
        height = 40;
    }else if (height <= 20) {
        height = 20;
    }
    CGFloat imageHeight = 0;
    if (model.images.count) {
        imageHeight = 90;
    }
    return 50 + 67 + 16 + height + imageHeight;
}

@end
