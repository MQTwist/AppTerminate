//
//  AppDelegate.m
//  AppTerminate
//
//  Created by ma qi on 2020/7/23.
//  Copyright © 2020 ma qi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self residentThread];
}

/** 不做任何处理 */
- (void)normal {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //模拟耗时处理
        sleep(1);
        NSLog(@">>>>do something");
    });
}

/** 使用信号量 */
- (void)semaphore {
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        //模拟耗时处理
        sleep(1);
        NSLog(@">>>>do something");
        dispatch_semaphore_signal(sem);
    });
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

- (void)residentThread {
    ///!!!:放在前面不行，要放在后面
//    [self performSelector:@selector(run) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //模拟耗时处理
        sleep(2);
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@">>>>do something");
    });
    [self performSelector:@selector(run) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
}

- (void)run {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(go) userInfo:nil repeats:YES];
    [timer fire];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    ///!!!:放在后面任务处理完后，还在继续
//    self.timer = timer;
}

- (void)go {
    NSLog(@">>>timer");
}

@end
