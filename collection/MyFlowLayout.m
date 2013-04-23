//
//  MyFlowLayout.m
//  collection
//
//  Created by sonson on 2013/04/15.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout

- (CGSize)collectionViewContentSize {
	CGSize size = [super collectionViewContentSize];
	if (self.selectedIndexPath)
		size.height += 100;
	return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	DNSLogMethod
	return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	DNSLogMethod
	
	NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
	
	if (self.selectedIndexPath) {
	
		UICollectionViewLayoutAttributes *selectedCellAttribute = [self layoutAttributesForItemAtIndexPath:self.selectedIndexPath];
		
		for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
			if (attributes.center.y > selectedCellAttribute.center.y + 1) {
				CGRect r = attributes.frame;
				r.origin.y += 100;
				attributes.frame = r;
				attributes.alpha = 0.2;
			}
			else
				attributes.alpha = 0.2;
			
			if (CGRectGetMidX(attributes.frame) == CGRectGetMidX(selectedCellAttribute.frame) && CGRectGetMidY(attributes.frame) == CGRectGetMidY(selectedCellAttribute.frame)) {
				attributes.alpha = 1.0;
			}
			DNSLogRect(attributes.frame);
		}
	}
	else {
		for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
			attributes.alpha = 1;
		}
	}
	return attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

@end
