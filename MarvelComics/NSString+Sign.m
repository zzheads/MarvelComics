//
//  NSString+Sign.m
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "NSString+Sign.h"

@implementation NSString (Sign)

-(NSString *) signWith:(char)appendingChar  {
    NSString *API_PUBLIC_KEY = @"5b1346e343ac0154ef9c202a6a1e9046";
    NSString *API_SECRET_KEY = @"f9228e567c5fd1b8a7485b4e44023e78c124c671";
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampLong = [NSNumber numberWithLong: timeStamp];
    NSString *timeStampString = [NSString stringWithFormat:@"%@", timeStampLong];
    
    // Sign example: http://gateway.marvel.com/v1/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
    NSString *sumOfAllKeys = [NSString stringWithFormat:@"%@%@%@", timeStampString, API_SECRET_KEY, API_PUBLIC_KEY];
    NSString *hash = [sumOfAllKeys MD5String];
    NSString *sign = [NSString stringWithFormat:@"%cts=%@&apikey=%@&hash=%@", appendingChar, timeStampString, API_PUBLIC_KEY, hash];
    return [NSString stringWithFormat:@"%@%@", self, sign];
}

@end
