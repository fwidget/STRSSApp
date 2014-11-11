//
//  STRSSResponseParser.h
//  STRSSApp
//
//  Created by MerryMacMini on 2014. 11. 11..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRSSResponseParser : NSObject < NSURLConnectionDataDelegate, NSXMLParserDelegate >

@property (nonatomic) NSInteger networkState;
@property (strong, nonatomic) NSString *feedUrlString;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong) STRSSChannel *parsedChannel;
@property (nonatomic, strong) NSMutableData *downloadedData;
@property (nonatomic, readonly) NSError *error;
@property (weak, nonatomic) id delegate;
@property (nonatomic) BOOL isSync; // 동기일 경우에 YES 비동기는 NO

@property BOOL isRss;
@property BOOL isChannel;
@property BOOL isItem;
@property NSMutableString *buffer;
@property NSMutableArray *items;
@property STRSSItem *currentItem;

- (void)parse;
- (void)canncel;
@end

@interface NSObject (STRSSReponseParserDelegate)
- (void)parser:(STRSSResponseParser *)parser didReceiveResponse:(NSURLResponse *)response;
- (void)parser:(STRSSResponseParser *)parser didReceiveData:(NSData *)data;
- (void)parserDidFinishLoading:(STRSSResponseParser *)parser;
- (void)parser:(STRSSResponseParser *)parser didFailWithError:(NSError *)error;
- (void)parserDidCancel:(STRSSResponseParser *)parser;

@end
