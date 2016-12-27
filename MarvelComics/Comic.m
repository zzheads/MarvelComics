//
//  Comic.m
//  MarvelComics
//
//  Created by Alexey Papin on 23.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

#import "Comic.h"

@implementation Comic

//id (int, optional): The unique ID of the comic resource.,
//digitalId (int, optional): The ID of the digital comic representation of this comic. Will be 0 if the comic is not available digitally.,
//title (string, optional): The canonical title of the comic.,
//issueNumber (double, optional): The number of the issue in the series (will generally be 0 for collection formats).,
//variantDescription (string, optional): If the issue is a variant (e.g. an alternate cover, second printing, or director’s cut), a text description of the variant.,
//description (string, optional): The preferred description of the comic.,
//modified (Date, optional): The date the resource was most recently modified.,
//isbn (string, optional): The ISBN for the comic (generally only populated for collection formats).,
//upc (string, optional): The UPC barcode number for the comic (generally only populated for periodical formats).,
//diamondCode (string, optional): The Diamond code for the comic.,
//ean (string, optional): The EAN barcode for the comic.,
//issn (string, optional): The ISSN barcode for the comic.,
//format (string, optional): The publication format of the comic e.g. comic, hardcover, trade paperback.,
//pageCount (int, optional): The number of story pages in the comic.,
//textObjects (Array[TextObject], optional): A set of descriptive text blurbs for the comic.,
//resourceURI (string, optional): The canonical URL identifier for this resource.,
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
//series (SeriesSummary, optional): A summary representation of the series to which this comic belongs.,
//variants (Array[ComicSummary], optional): A list of variant issues for this comic (includes the "original" issue if the current issue is a variant).,
//collections (Array[ComicSummary], optional): A list of collections which include this comic (will generally be empty if the comic's format is a collection).,
//collectedIssues (Array[ComicSummary], optional): A list of issues collected in this comic (will generally be empty for periodical formats such as "comic" or "magazine").,
//dates (Array[ComicDate], optional): A list of key dates for this comic.,
//prices (Array[ComicPrice], optional): A list of prices for this comic.,
//thumbnail (Image, optional): The representative image for this comic.,
//images (Array[Image], optional): A list of promotional images associated with this comic.,
//creators (CreatorList, optional): A resource list containing the creators associated with this comic.,
//characters (CharacterList, optional): A resource list containing the characters which appear in this comic.,
//stories (StoryList, optional): A resource list containing the stories which appear in this comic.,
//events (EventList, optional): A resource list containing the events in which this comic appears.

@dynamic title, desc, thumbnail;

- (id) initWithJson:(NSDictionary *)json {
    self = [super init];
    
    self.id = [json[@"id"] intValue];
    self.digitalId = [json[@"digitalId"] intValue];
    self.title = json[@"title"];
    self.issueNumber = [json[@"issueNumber"] doubleValue];
    self.variantDescription = json[@"variantDescription"];
    self.desc = json[@"description"];
    self.modified = json[@"modified"];
    self.isbn = json[@"isbn"];
    self.upc = json[@"upc"];
    self.diamondCode = json[@"diamondCode"];
    self.ean = json[@"ean"];
    self.issn = json[@"issn"];
    self.format = json[@"format"];
    self.pageCount = [json[@"pageCount"] intValue];
    self.textObjects = [NSArray arrayFromJson:json[@"textObjects"] :[TextObject parser]];
    self.resourceURI = json[@"resourceURI"];
    self.urls = [NSArray arrayFromJson:json[@"urls"] :[Url parser]];
    self.series = [[Summary alloc] initWithJson:json[@"series"]];
    self.variants = [NSArray arrayFromJson:json[@"variants"] :[Summary parser]];
    self.collections = [NSArray arrayFromJson:json[@"collections"] :[Summary parser]];
    self.collectedIssues = [NSArray arrayFromJson:json[@"collectedIssues"] :[Summary parser]];
    self.dates = [NSArray arrayFromJson:json[@"dates"] :[ComicDate parser]];
    self.prices = [NSArray arrayFromJson:json[@"prices"] :[ComicPrice parser]];
    self.thumbnail = [[Image alloc] initWithJson: json[@"thumbnail"]];
    self.images = [NSArray arrayFromJson:json[@"images"] :[Image parser]];
    self.creators = [[List alloc] initWithJson:json[@"creators"]];
    self.characters = [[List alloc] initWithJson:json[@"characters"]];
    self.stories = [[List alloc] initWithJson:json[@"stories"]];
    self.events = [[List alloc] initWithJson:json[@"events"]];
    
    return self;
}

+(ParseFromJson)parser {
    return ^id(NSDictionary *json) {
        return [[Comic alloc] initWithJson:json];
    };
}

@end
