//
//  LCHSoundTool.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHSoundTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LCHSoundTool ()

+ (instancetype)sharedSoundTool;

- (void)playMusicWithSoundName:(NSString *)soundName;

@end


static LCHSoundTool *sharedSoundTool;
@implementation LCHSoundTool

+ (instancetype)sharedSoundTool {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSoundTool = [[LCHSoundTool alloc] init];
    });
    return sharedSoundTool;
}

+ (void)playPipeSound {
    
    LCHSoundTool *soundTool = [self sharedSoundTool];
    NSString *soundName = @"pipe";
    [soundTool playMusicWithSoundName:soundName];
    
}

+ (void)playPunchSound {
    
    LCHSoundTool *soundTool = [self sharedSoundTool];
    NSString *soundName = @"punch";
    [soundTool playMusicWithSoundName:soundName];
}

- (void)playMusicWithSoundName:(NSString *)soundName {
    
    NSURL *musicURL = [[NSBundle bundleWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sounds.bundle"]] URLForResource:soundName withExtension:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(musicURL), &soundID);
    AudioServicesPlayAlertSound(soundID);
}


@end
