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
    
    _channels = [NSArray array]; // 프로퍼티의 형식이 틀린 것에 주의!! 프로퍼티로의 수정을 막고, 내부에서만 수정 가능하게 하기 위한 설정
    
    return self;
}


#pragma mark - method
- (void)updateChannel:(STRSSChannel *)channel atIndex:(NSUInteger)index
{
    if (!channel || index < 0 || index > [_channels count] - 1) {
        return;
    }

    NSMutableArray *channelArr = _channels.mutableCopy;
    [channelArr replaceObjectAtIndex:index withObject:channel];
    _channels = (NSArray *)channelArr;

}
- (void)addChannel:(STRSSChannel *)channel
{
    if (!channel) {
        return;
    }
    NSMutableArray *channelArr = _channels.mutableCopy;
    [channelArr addObject:channel];
    _channels = (NSArray *)channelArr;
}

- (void)insertChannel:(STRSSChannel *)channel atIndex:(NSUInteger)index
{
    if (!channel) {
        return;
    }
    
    if (0 > index || index > [_channels count]) {
        return;
    }
    NSMutableArray *channelArr = _channels.mutableCopy;
    [channelArr insertObject:channel atIndex:index];
    _channels = (NSArray *)channelArr;
}

- (void)removeChannel:(NSUInteger)index
{
    if (0 > index || index > [_channels count] - 1) {
        return;
    }
    NSMutableArray *channelArr = _channels.mutableCopy;
    [channelArr removeObjectAtIndex:index];
    _channels = (NSArray *)channelArr;
}

- (void)moveChannelAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (0 > fromIndex || fromIndex > [_channels count] - 1) {
        return;
    }
    if (0 > toIndex || toIndex > [_channels count]) {
        return;
    }
    
    NSMutableArray *channelArr = _channels.mutableCopy;
    STRSSChannel *channel = channelArr[fromIndex];
    [channelArr removeObjectAtIndex:fromIndex];
    [channelArr insertObject:channel atIndex:toIndex];
    _channels = (NSArray *)channelArr;
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
    NSString *path = [[self _channelDir] stringByAppendingPathComponent:@"channel.dat"];
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
    [NSKeyedArchiver archiveRootObject:_channels toFile:channelPath];
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
    
    _channels = channels;
}

@end
