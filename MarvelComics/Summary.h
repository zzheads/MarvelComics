//
//  Summary.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Summary : NSObject

//resourceURI (string, optional): The path to the individual story resource.,
//name (string, optional): The canonical name of the story.,
//type (string, optional): The type of the story (interior or cover).

@property (nonatomic, strong) NSString *resourceURI;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

+(NSArray *) getSummaries: (NSArray *) jsonArray;

@end
