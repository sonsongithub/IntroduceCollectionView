//
//  MyFlowLayout.m
//  collection
//
//  Created by sonson on 2013/04/15.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	DNSLogMethod
	return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	DNSLogMethod
	
	NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		DNSLogRect(attributes.frame);
		DNSLogSize(attributes.size);
	}
	return attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

@end
