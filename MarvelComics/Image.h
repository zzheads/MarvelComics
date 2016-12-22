//
//  Image.h
//  MarvelComics
//
//  Created by Alexey Papin on 22.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

//path (string, optional): The directory path of to the image.,
//extension (string, optional): The file extension for the image.

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *extension;

-(id) initWithJson: (NSDictionary *) json;

@end
