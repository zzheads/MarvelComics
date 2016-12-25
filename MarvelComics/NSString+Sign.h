//
//  NSString+Sign.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD5.h"

@interface NSString (Sign)

-(NSString *) signWith:(char)appendingChar;
-(NSString *) secureHTTP;

@end
