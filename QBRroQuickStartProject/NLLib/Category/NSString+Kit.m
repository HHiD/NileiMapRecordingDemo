//
//  NSString+Kit.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "NSString+Kit.h"

@implementation NSString (Kit)

+ (NSString*)convertTimeWithTimeInterval:(NSInteger)interval {
    if (interval > 0) {
        NSString *hour   = [NSString hour:interval];
        NSString *minute = [NSString minute:interval];
        NSString *second = [NSString second:interval];
        return [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
    }
    else {
        return @"00:00";
    }
}

+ (NSString*)second:(NSInteger)number {
    NSInteger remains = number%3600;
    NSInteger result  = remains%60;
    if (result<10) {
        return [NSString stringWithFormat:@"0%ld",result];
    }
    else {
        return [NSString stringWithFormat:@"%ld",result];
    }
}
+ (NSString*)minute:(NSInteger)number {
    NSInteger remains = number%3600;
    NSInteger result  = remains/60;
    if (result<10) {
       return [NSString stringWithFormat:@"0%ld",result];
    }
    else {
        return [NSString stringWithFormat:@"%ld",result];
    }
}
+ (NSString*)hour:(NSInteger)number {
    NSInteger result = number/3600;
    if (result>0) {
        if (result<10) {
          return [NSString stringWithFormat:@"0%ld",result];
        }
        else {
            return [NSString stringWithFormat:@"0%ld",result];
        }
    }
    else {
         return @"00";
    }
    
}
@end
