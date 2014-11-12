//
//  STRSSConnector.m
//  STRSSApp
//
//  Created by MerryMacMini on 2014. 11. 12..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSConnector.h"
#import "STRSSResponseParser.h"

static STRSSConnector * _sharedConnector;

@implementation STRSSConnector

+ (STRSSConnector *)sharedConnector
{
    if (!_sharedConnector) {
        _sharedConnector = [[STRSSConnector alloc] init];
    }
    return _sharedConnector;
}

- (void)retrieveTitleWithUrlString:(NSString *)urlString
{
    if ([self isRefreshingallChannels]) {
        return;
    }

    BOOL networkAccessing = self.networkAccessing;

    STRSSResponseParser *parser = [[STRSSResponseParser alloc] init];
    parser.feedUrlString = urlString;
    parser.delegate = self;

    [parser parse];

    if (networkAccessing != self.networkAccessing) {
        [self willChangeValueForKey:@"networkAccessing"];
        [self didChangeValueForKey:@"networkAccessing"];
    }
}

- (void)cancelRetrieveTitleUrlString:(NSString *)urlString
{
    if ([self isRefreshingallChannels]) {
        return;
    }

    BOOL networkAccessing = self.networkAccessing;

    STRSSResponseParser *parser = [[STRSSResponseParser alloc] init];
    parser.feedUrlString = urlString;
    parser.delegate = self;
    [parser canncel];

    if (networkAccessing != self.networkAccessing) {
        [self willChangeValueForKey:@"networkAccessing"];
        [self didChangeValueForKey:@"networkAccessing"];
    }
}

- (BOOL)isRefreshingallChannels
{
    return ([[STRSSChannelManager sharedManager].channels count] == [_refreshAllChannelParsers count]) ? YES : NO ;
}


- (float)progressOfRefreshAllChannels
{
    return [[STRSSChannelManager sharedManager].channels count] / [_refreshAllChannelParsers count] * 100;
}

- (void)cancelRefreshAllChannels
{


}

- (BOOL)isNetworkAccessing
{
    return [_retrieveTitleRarsers count] > 0 || [_refreshAllChannelParsers count] > 0 ;
}

- (void)refreshAllChannels
{
    if ([self isRefreshingallChannels]) {
        return;
    }

    BOOL networkAccessing = self.networkAccessing;

    NSArray *channels = [STRSSChannelManager sharedManager].channels;

    for (STRSSChannel *channel in channels) {
        STRSSResponseParser *parser = [[STRSSResponseParser alloc] init];
        parser.feedUrlString = channel.feedUrlString;
        parser.delegate = self;

        [parser parse];

        [_refreshAllChannelParsers addObject:parser];
    }

    if (networkAccessing != self.networkAccessing) {
        [self willChangeValueForKey:@"networkAccessing"];
        [self didChangeValueForKey:@"networkAccessing"];
    }
}
//- (void)parser:(STRSSResponseParser *)parser didReceiveResponse:(NSURLResponse *)response;
//- (void)parser:(STRSSResponseParser *)parser didReceiveData:(NSData *)data;
//- (void)parserDidFinishLoading:(STRSSResponseParser *)parser;
//- (void)parser:(STRSSResponseParser *)parser didFailWithError:(NSError *)error;
//- (void)parserDidCancel:(STRSSResponseParser *)parser;
@end
