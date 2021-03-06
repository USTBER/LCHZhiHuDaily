//
//  LCHDataManager.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessBlockWithArray)(NSMutableArray *models);
typedef void(^SuccessBlockWithDic)(NSMutableDictionary *modelsWithKeys);
typedef void(^FailedBlock)(NSError *);
typedef void (^SuccessBlock)(id returnModel);


@interface LCHDataManager : NSObject

/**
 *  获取lanch页面的背景图url与标题
 *
 *  @param url          获取lanch页面资源的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getLanchPageResouce:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取主题列表的相关信息
 *
 *  @param url          获取leftSideDrawer页面资源的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getLeftSideDrawerThemes:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取具体主题列表内的新闻信息
 *
 *  @param url          获取ThemePage页面资源的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getThemeNews:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取首页显示的最新的新闻信息
 *
 *  @param url          获取homePage页面最新资源的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getHomePageLatestNews:(NSString *)url success:(SuccessBlockWithArray)successBlock failed:(FailedBlock)failedBlock;



/**
 *  获取首页显示的前段时间的新闻信息
 *
 *  @param url          获取homePage页面前段时间资源的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getHomePageBeforeNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;


/**
 *  获取某条新闻的具体信息
 *
 *  @param url          获取具体新闻信息的的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getDetailNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;


/**
 *  获取某条新闻的额外信息
 *
 *  @param url          获取具体新闻额外信息的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getNewsExtraData:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取某条新闻的具体信息
 *
 *  @param url          获取具体新闻信息的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getThemeDetailNews:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取某条新闻的长评论信息
 *
 *  @param url          获取具体新闻长评论的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getNewsLongComment:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;

/**
 *  获取某条新闻的短评论信息
 *
 *  @param url          获取具体新闻短评论的api
 *  @param successBlock 成功的回调
 *  @param failedBlock  失败的回调
 */
+ (void)getNewsShortComment:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;


@end
