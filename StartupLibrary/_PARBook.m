// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PARBook.m instead.

#import "_PARBook.h"

const struct PARBookAttributes PARBookAttributes = {
	.author = @"author",
	.bookURL = @"bookURL",
	.category = @"category",
	.coverURL = @"coverURL",
	.createdAt = @"createdAt",
	.objectId = @"objectId",
	.summary = @"summary",
	.tags = @"tags",
	.title = @"title",
	.updatedAt = @"updatedAt",
	.webURL = @"webURL",
};

const struct PARBookRelationships PARBookRelationships = {
	.notes = @"notes",
};

@implementation PARBookID
@end

@implementation _PARBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PARBook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PARBook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PARBook" inManagedObjectContext:moc_];
}

- (PARBookID*)objectID {
	return (PARBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic author;

@dynamic bookURL;

@dynamic category;

@dynamic coverURL;

@dynamic createdAt;

@dynamic objectId;

@dynamic summary;

@dynamic tags;

@dynamic title;

@dynamic updatedAt;

@dynamic webURL;

@dynamic notes;

@end

