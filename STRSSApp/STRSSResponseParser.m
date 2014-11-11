//
//  STRSSResponseParser.m
//  STRSSApp
//
//  Created by MerryMacMini on 2014. 11. 11..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSResponseParser.h"

typedef enum : NSUInteger {
    STRSSNetworkStateInProgress,
    STRSSNetworkStateFinished,
    STRSSNetworkStateError,
    STRSSNetworkStateCanceled,
} STRSSNetworkState;

@implementation STRSSResponseParser

- (void)parse
{
    if (_isSync) {
        [NSThread detachNewThreadSelector:@selector(_parser) toTarget:self withObject:nil];
        return;
    }


    NSURLRequest *request = nil;
    if (_feedUrlString) {
        NSURL *url = [NSURL URLWithString:_feedUrlString];
        if (url) {
            request = [NSURLRequest requestWithURL:url];
        }
    }

    if (!request) {
        return;
    }

    _downloadedData = [NSMutableData data];

    _connection = [NSURLConnection connectionWithRequest:request delegate:self];

    _networkState = STRSSNetworkStateInProgress;
}

// 비동기 파서
- (void)_parser
{
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:_feedUrlString];
        if (!url) {
            return;
        }

        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        if (!request) {
            return;
        }

        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

        if (error) {
            [self performSelectorOnMainThread:@selector(_notifyParserDidFailWithError:) withObject:error waitUntilDone:YES];
        } else {
            //TODO:데이터 파서 처리
            data = data;
            [self performSelectorOnMainThread:@selector(_notifyParserDidFinishLoading) withObject:error waitUntilDone:YES];
        }
    }
}

- (void)canncel
{
    [_connection cancel];

    _networkState = STRSSNetworkStateCanceled;

    if ([_delegate respondsToSelector:@selector(parserDidCancel:)]) {
        [_delegate parserDidCancel:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([_delegate respondsToSelector:@selector(parser:didReceiveResponse:)]) {
        [_delegate parser:self didReceiveResponse:response];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadedData appendData:data];

    if ([_delegate respondsToSelector:@selector(parser:didReceiveData:)]) {
        [_delegate parser:self didReceiveData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // TODO:데이터 파스 처래
    _networkState = STRSSNetworkStateFinished;

    if ([_delegate respondsToSelector:@selector(parserDidFinishLoading:)]) {
        [_delegate parserDidFinishLoading:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _networkState = STRSSNetworkStateError;

    if ([_delegate respondsToSelector:@selector(parser:didFailWithError:)]) {
        [_delegate parser:self didFailWithError:error];
    }
}

#pragma mark notify
- (void)_notifyParserDidFailWithError:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(parser:didFailWithError:)]) {
        [_delegate parser:self didFailWithError:error];
    }
}
- (void)_notifyParserDidFinishLoading
{
    if ([_delegate respondsToSelector:@selector(parserDidFinishLoading:)]) {
        [_delegate parserDidFinishLoading:self];
    }
}

@end
