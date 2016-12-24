//
//  Url.h
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Url : NSObject

//type (string, optional): A text identifier for the URL.,
//url (string, optional): A full URL (including scheme, domain, and path).

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;

- (id) initWithJson:(NSDictionary *)json;

@end
