//
//  STRSSChannel.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSChannel.h"

@implementation STRSSChannel

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    CFUUIDRef uuid;
    uuid = CFUUIDCreate(NULL);
    _identifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid)); //ARC대응
    CFRelease(uuid);
    
    _items = [NSMutableArray array];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_feedUrlString forKey:@"feedUrlString"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_link forKey:@"link"];
    [aCoder encodeObject:_items forKey:@"items"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _identifier = [aDecoder decodeObjectForKey:@"identifier"];
    _feedUrlString = [aDecoder decodeObjectForKey:@"feedUrlString"];
    _title = [aDecoder decodeObjectForKey:@"title"];
    _link = [aDecoder decodeObjectForKey:@"link"];
    _items = [aDecoder decodeObjectForKey:@"items"];

    return self;
}
@end
