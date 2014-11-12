//
//  STRSSConnector.h
//  STRSSApp
//
//  Created by MerryMacMini on 2014. 11. 12..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRSSConnector : NSObject
{
    NSMutableArray *_retrieveTitleRarsers;
    NSMutableArray * _refreshAllChannelParsers;
}

@property (nonatomic, readonly, getter=isNetworkAccessing) BOOL networkAccessing;
+ (STRSSConnector *)sharedConnector;

- (void)retrieveTitleWithUrlString:(NSString *)urlString;
- (void)cancelRetrieveTitleUrlString:(NSString *)urlString;

- (BOOL)isRefreshingallChannels;
- (void)refreshAllChannels;
- (float)progressOfRefreshAllChannels;
- (void)cancelRefreshAllChannels;

@end
