//
//  BQMainViewController.h
//  Community
//
//  Created by Shaolin Zhou on 2022/9/14.
//

#import "BQViewController.h"
#import "BQGeneralMacro.h"

typedef void(^BQShowSideMenuBlock)(void);


NS_ASSUME_NONNULL_BEGIN

@interface BQMainViewController : BQViewController
@property(nonatomic, copy) BQShowSideMenuBlock sideMenuBlock;

@end

NS_ASSUME_NONNULL_END
