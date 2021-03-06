//
//  STRSSChannelManager.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STRSSChannel, STRSSItem;

@interface STRSSChannelManager : NSObject
{
    NSMutableArray *channels_;
}

@property (nonatomic, readonly) NSArray *channels;

+ (STRSSChannelManager*)sharedManager;

- (void)addChannel:(STRSSChannel *)channel;
- (void)insertChannel:(STRSSChannel *)channel atIndex:(NSUInteger)index;
- (void)removeChannel:(NSUInteger)index;
- (void)moveChannelAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
