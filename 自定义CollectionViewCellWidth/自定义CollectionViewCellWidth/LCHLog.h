//
//  LCHLog.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef LCHLog_h
#define LCHLog_h

#define LCH_LOG_NULL_ERROR NSLog(@"LCHError:Error in method : %s; at time : %@; of type : value can't be null", __func__, [NSDate date])

#define LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR NSLog(@"LCHError:Error in method : %s; at time : %@; of type : delegate is null or did not response to correct selector", __func__, [NSDate date])



#endif /* LCHLog_h */
