//
//  ViewController.m
//  LCHPhoto
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    PHAsset *asset = [[PHAsset alloc] init];
    //
    //    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    //    option.synchronous = true;
    //    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    //
    //    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
    //
    //        NSArray *arr = [info allKeys];
    //        for (NSString *key in arr) {
    //            NSLog(@"key is %@ and value is %@", key, [info valueForKey:key]);
    //        }
    //    }];
    
    
    for (int i = 0; i < 10; i++) {
        
        dispatch_queue_t queue = dispatch_queue_create("xx", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            
            PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
            fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
            PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
            PHAsset *lastAsset = [fetchResult lastObject];
            [[PHImageManager defaultManager] requestImageForAsset:lastAsset
                                                       targetSize:[UIScreen mainScreen].bounds.size
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        
//                                                        NSArray *arr = [info allKeys];
//                                                        for (NSString *key in arr) {
//                                                            
//                                                            NSLog(@"key is %@ and value is %@", key, [info objectForKey:key]);
//                                                        }
                                                        
                                                        if (!result) {
                                                            return ;
                                                        }
                                                        
                                                        NSLog(@"Number is %d and info is %@", i, info);
                                                        
                                                        
                                                    }];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
