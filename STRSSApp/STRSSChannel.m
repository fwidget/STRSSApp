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
@end
