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
#import "LCHDetailNewsModel.h"
#import "LCHThemeDetailNewsModel.h"
#import "LCHNewsExtraData.h"
#import "LCHLongCommentJsonModel.h"
#import "LCHLongCommentModel.h"
#import "LCHShortCommentJsonModel.h"
#import "LCHShortCommentModel.h"

#import <AFNetworking.h>
#import <YYModel.h>

typedef NS_ENUM(NSUInteger, LCHDataManagerErrorCode) {
    LCHDataManagerReturnValueNilError
};

typedef void (^SuccessBlockWithJson)(id returnObject);

@interface LCHDataManager ()

+ (void)getDataWithURL:(NSString *)url success:(SuccessBlockWithJson)successBlock failed:(FailedBlock)failedBlock;

@end

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
        if (latestJsonModel.stories.count > 0 && latestJsonModel.top_stories.count > 0) {
            
            LCHHomePageBeforeJsonModel *todayNewsJsonModel = [[LCHHomePageBeforeJsonModel alloc] init];
            todayNewsJsonModel.date = latestJsonModel.date;
            todayNewsJsonModel.stories = latestJsonModel.stories;
            
            NSMutableArray *topNews = [[NSMutableArray alloc] initWithCapacity:latestJsonModel.top_stories.count];
            
            topNews = latestJsonModel.top_stories;
            
            NSMutableArray *tem = [[NSMutableArray alloc] init];
            [tem addObject:todayNewsJsonModel];
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



+ (void)getHomePageBeforeNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCHHomePageBeforeJsonModel *beforeJsonModel = [LCHHomePageBeforeJsonModel yy_modelWithJSON:responseObject];
        
        if (beforeJsonModel.stories.count > 0) {
            successBlock(beforeJsonModel);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getHomePageBeforeNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
}

+ (void)getDetailNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    [self getDataWithURL:url success:^(id returnObject) {
        
        LCHDetailNewsModel *detailNewsModel = [LCHDetailNewsModel yy_modelWithJSON:returnObject];
        if (detailNewsModel) {
            successBlock(detailNewsModel);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getDetailNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
    } failed:^(NSError *error) {
        failedBlock(error);
    }];
}


+ (void)getNewsExtraData:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    [self getDataWithURL:url success:^(id returnObject) {
        
        LCHNewsExtraData *newsExtraData = [LCHNewsExtraData yy_modelWithJSON:returnObject];
        if (newsExtraData) {
            successBlock(newsExtraData);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getNewsExtraData" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
    } failed:^(NSError *error) {
        failedBlock(error);
    }];
}


+ (void)getThemeDetailNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    [self getDataWithURL:url success:^(id returnObject) {
        
        LCHThemeDetailNewsModel *detailNewsModel = [LCHThemeDetailNewsModel yy_modelWithJSON:returnObject];
        if (detailNewsModel) {
            successBlock(detailNewsModel);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getDetailNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
    } failed:^(NSError *error) {
        failedBlock(error);
    }];
}

+ (void)getNewsLongComment:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
 
    [self getDataWithURL:url success:^(id returnObject) {
        
        LCHLongCommentJsonModel *longCommentJsonModel = [LCHLongCommentJsonModel yy_modelWithJSON:returnObject];
        if (longCommentJsonModel) {
            successBlock(longCommentJsonModel);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getNewsLongComment" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
    } failed:^(NSError *error) {
        failedBlock(error);
    }];
}

+ (void)getNewsShortComment:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    [self getDataWithURL:url success:^(id returnObject) {
        
        LCHShortCommentJsonModel *shortCommentJsonModel = [LCHShortCommentJsonModel yy_modelWithJSON:returnObject];
        if (shortCommentJsonModel) {
            successBlock(shortCommentJsonModel);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"LCHDataManager:getDetailNews" code:LCHDataManagerReturnValueNilError userInfo:nil];
            failedBlock(error);
        }
    } failed:^(NSError *error) {
        failedBlock(error);
    }];
}

+ (void)getDataWithURL:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
}

@end
