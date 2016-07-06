//
//  LCHLongCommentModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHLongCommentModel : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) LCHLongCommentModel *reply_to;

@end
