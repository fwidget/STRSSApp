//
//  STRSSChannelManager.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSChannelManager.h"

static STRSSChannelManager * _sharedInstance;

@implementation STRSSChannelManager

+ (STRSSChannelManager *)sharedManager
{
    if (!_sharedInstance) {
        _sharedInstance = [[STRSSChannelManager alloc] init];
    }
    
    return _sharedInstance;
}


- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    channels_ = [NSMutableArray array]; // 프로퍼티의 형식이 틀린 것에 주의!! 프로퍼티로의 수정을 막고, 내부에서만 수정 가능하게 하기 위한 설정
    
    return self;
}


#pragma mark - method
- (void)addChannel:(STRSSChannel *)channel
{
    if (!channel) {
        return;
    }
    
    [channels_ addObject:channel];
}

- (void)insertChannel:(STRSSChannel *)channel atIndex:(NSUInteger)index
{
    if (!channel) {
        return;
    }
    
    if (-1 >= index || index > [channels_ count]) {
        return;
    }
    
    [channels_ insertObject:channel atIndex:index];
}

- (void)removeChannel:(NSUInteger)index
{
    if (-1 >= index || index > [channels_ count] - 1) {
        return;
    }
    
    [channels_ removeObjectAtIndex:index];
}

- (void)moveChannelAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (-1 >= fromIndex || fromIndex > [channels_ count] - 1) {
        return;
    }
    if (-1 >= toIndex || toIndex > [channels_ count]) {
        return;
    }
    
    STRSSChannel *channel;
    channel = channels_[fromIndex];
    [channels_ removeObjectAtIndex:fromIndex];
    [channels_ insertObject:channel atIndex:toIndex];
    
}


#pragma mark - Path
- (NSString *)_channelDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    if (paths.count < 1) {
        return nil;
    }
    
    NSString *path = paths.firstObject;
    
    path = [path stringByAppendingPathComponent:@".channel"];
    return path;
}


- (NSString *)_channelPath
{
    NSString *path = [[self _channelPath] stringByAppendingPathComponent:@"channel.dat"];
    return path;
}

#pragma mark - Save & Load
- (void)save
{
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    
    NSString *channelDir = [self _channelDir];
    if (![fileManager fileExistsAtPath:channelDir]) {
        NSError *error;
        [fileManager createDirectoryAtPath:channelDir withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString *channelPath = [self _channelPath];
    [NSKeyedArchiver archiveRootObject:channels_ toFile:channelPath];
}

- (void)load
{
    NSString *channelPath = [self _channelPath];
    if (!channelPath || ![[NSFileManager defaultManager] fileExistsAtPath:channelPath]) {
        return;
    }
    
    NSArray *channels = [NSKeyedUnarchiver unarchiveObjectWithFile:channelPath];
    if (!channels) {
        return;
    }
    
    [channels_ setArray:channels];
    
    _channels = (NSArray *)channels_;
}

@end
