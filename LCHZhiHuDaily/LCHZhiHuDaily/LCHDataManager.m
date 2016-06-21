//
//  LCHDataManager.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHDataManager.h"
#import "LCHLaunchModel.h"
#import "LCHThemesJsonModel.h"
#import "LCHThemeModel.h"
#import "LCHThemeNewsModel.h"
#import "LCHThemeNewsJsonModel.h"
#import "LCHHomePageTopNewsModel.h"
#import "LCHHomePageNewsModel.h"
#import "LCHHomePageLatestJsonModel.h"
#import "LCHHomePageBeforeJsonModel.h"
#import <AFNetworking.h>
#import <YYModel.h>

typedef NS_ENUM(NSUInteger, LCHDataManagerErrorCode) {
    LCHDataManagerReturnValueNilError
};

@implementation LCHDataManager

+ (void)getLanchPageResouce:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHLaunchModel *launchModel = [LCHLaunchModel yy_modelWithJSON:responseObject];
        NSMutableArray *tem = [[NSMutableArray alloc] init];
        if (launchModel) {
            [tem addObject:launchModel];
            successBlock(tem);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getLanchPageResouce" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
}

+ (void)getLeftSideDrawerThemes:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHThemesJsonModel *themesJsonModel = [LCHThemesJsonModel yy_modelWithJSON:responseObject];
        
        if (themesJsonModel.others) {
            NSMutableArray *themeModels = [[NSMutableArray alloc] initWithCapacity:themesJsonModel.others.count];
            
            [themesJsonModel.others enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LCHThemeModel *themeModel = [LCHThemeModel yy_modelWithJSON:themesJsonModel.others[idx]];
                if (themeModel) {
                    [themeModels insertObject:themeModel atIndex:idx];
                }
            }];
            
            successBlock(themeModels);
            
        } else {
            
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getLeftSideDrawerThemes" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
}


+ (void)getThemeNews:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHThemeNewsJsonModel *themeNewsJsonModel = [LCHThemeNewsJsonModel yy_modelWithJSON:responseObject];
        if (themeNewsJsonModel.stories) {
            
            NSMutableArray *themeNewsmodels = [[NSMutableArray alloc] initWithCapacity:themeNewsJsonModel.stories.count];
            
            [themeNewsJsonModel.stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                LCHThemeNewsModel *themeNewsModel = [LCHThemeNewsModel yy_modelWithJSON:themeNewsJsonModel.stories[idx]];
                if (themeNewsModel) {
                    [themeNewsmodels insertObject:themeNewsModel atIndex:idx];
                }
                
            }];
            successBlock(themeNewsmodels);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getThemeNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
}

+ (void)getHomePageLatestNews:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHHomePageLatestJsonModel *latestJsonModel = [LCHHomePageLatestJsonModel yy_modelWithJSON:responseObject];
        if (latestJsonModel.stories.count > 0) {
            
            NSMutableArray *latestNews = [[NSMutableArray alloc] initWithCapacity:latestJsonModel.stories.count];
            
            NSMutableArray *topNews = [[NSMutableArray alloc] initWithCapacity:latestJsonModel.top_stories.count];
            
            //            [latestJsonModel.stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //                LCHHomePageNewsModel *newsModel = [LCHHomePageNewsModel yy_modelWithJSON:obj];
            //                if (newsModel) {
            //                    [latestNews insertObject:newsModel atIndex:idx];
            //                }
            //            }];
            latestNews = latestJsonModel.stories;
            
            //            [latestJsonModel.top_stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //                LCHHomePageTopNewsModel *newsModel = [LCHHomePageTopNewsModel yy_modelWithJSON:obj];
            //                if (newsModel) {
            //                    [topNews insertObject:newsModel atIndex:idx];
            //                }
            //            }];
            topNews = latestJsonModel.top_stories;
            
            NSMutableArray *tem = [[NSMutableArray alloc] init];
            [tem addObject:latestNews];
            [tem addObject:topNews];
            successBlock(tem);
            
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getHomePageLatestNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
}


+ (void)getHomePageBeforeNews:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHHomePageBeforeJsonModel *beforeJsonModel = [LCHHomePageBeforeJsonModel yy_modelWithJSON:responseObject];
        
        if (beforeJsonModel.stories.count > 0) {
            
            //            NSMutableArray *beforeNews = [[NSMutableArray alloc] initWithCapacity:beforeJsonModel.stories.count];
            //            [beforeJsonModel.stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            //                LCHHomePageNewsModel *newsModel = [LCHHomePageNewsModel yy_modelWithJSON:obj];
            //                if (newsModel) {
            //                    [beforeNews insertObject:newsModel atIndex:idx];
            //                }
            //            }];
            //            beforeNews = beforeJsonModel.stories;
            successBlock(beforeJsonModel.stories);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getHomePageBeforeNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
}

//+ (void)getHomePageBeforeNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
//
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        LCHHomePageBeforeJsonModel *beforeJsonModel = [LCHHomePageBeforeJsonModel yy_modelWithJSON:responseObject];
//
//        if (beforeJsonModel.stories.count > 0) {
//            successBlock(beforeJsonModel);
//        } else {
//            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getHomePageBeforeNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
//            failedBlock(error);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failedBlock(error);
//    }];
//}



@end
