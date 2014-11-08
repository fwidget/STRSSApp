//
//  STRSSItem.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSItem.h"

@implementation STRSSItem

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
    
    return self;
}


// NSCoder 프로토콜은 데이터를 클래스 형식으로 저장하기 위할 경우에 사용함
// 상속관계에서는 부모 클래스를 호출해주어야 함.(이유 : 자신만 저장하기 때문에)

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeBool:_read forKey:@"read"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_link forKey:@"link"];
    [aCoder encodeObject:_itemDescription forKey:@"itemDescription"];
    [aCoder encodeObject:_pubDate forKey:@"pubDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _identifier = [aDecoder decodeObjectForKey:@"identifier"];
    _read = [aDecoder decodeBoolForKey:@"read"];
    _title = [aDecoder decodeObjectForKey:@"title"];
    _link = [aDecoder decodeObjectForKey:@"link"];
    _itemDescription = [aDecoder decodeObjectForKey:@"itemDescription"];
    _pubDate = [aDecoder decodeObjectForKey:@"pubDate"];

    return self;
}

@end
