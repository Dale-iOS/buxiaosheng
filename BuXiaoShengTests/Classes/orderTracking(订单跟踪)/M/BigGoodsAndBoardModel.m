//
//  BigGoodsAndBoardModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BigGoodsAndBoardModel.h"

@implementation ItemList
- (id)copyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];

	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}

	free(properties);
	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];
		if([value respondsToSelector:@selector(copyWithZone:)])
		{[objCopy setValue:[value copy] forKey:name];}
		else
		{[objCopy setValue:value  forKey:name];}
	}
	return objCopy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}
	free(properties);

	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];

		if([value respondsToSelector:@selector(mutableCopyWithZone:)])
		{[objCopy setValue:[value mutableCopy] forKey:name];}
		else
		{[objCopy setValue:value forKey:name];}
	}
	return objCopy;
}


@end


@implementation BatchNumberList
- (id)copyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];

	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}

	free(properties);
	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];
		if([value respondsToSelector:@selector(copyWithZone:)])
		{[objCopy setValue:[value copy] forKey:name];}
		else
		{[objCopy setValue:value  forKey:name];}
	}
	return objCopy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}
	free(properties);

	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];

		if([value respondsToSelector:@selector(mutableCopyWithZone:)])
		{[objCopy setValue:[value mutableCopy] forKey:name];}
		else
		{[objCopy setValue:value forKey:name];}
	}
	return objCopy;
}


@end


@implementation BigGoodsAndBoardModel
- (id)copyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];

	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}

	free(properties);
	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];
		if([value respondsToSelector:@selector(copyWithZone:)])
		{[objCopy setValue:[value copy] forKey:name];}
		else
		{[objCopy setValue:value  forKey:name];}
	}
	return objCopy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
	id objCopy = [[[self class] allocWithZone:zone] init];
	Class clazz = [self class];
	u_int count;
	objc_property_t* properties = class_copyPropertyList(clazz, &count);
	NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
	for (int i = 0; i < count ; i++)
	{
		const char* propertyName = property_getName(properties[i]);
		[propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
	}
	free(properties);

	for (int i = 0; i < count ; i++)
	{
		NSString *name=[propertyArray objectAtIndex:i];
		id value=[self valueForKey:name];

		if([value respondsToSelector:@selector(mutableCopyWithZone:)])
		{[objCopy setValue:[value mutableCopy] forKey:name];}
		else
		{[objCopy setValue:value forKey:name];}
	}
	return objCopy;
}


@end
