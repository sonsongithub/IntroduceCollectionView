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
	
//	self.selectedIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
	
	if (self.selectedIndexPath) {
	
	UICollectionViewCell *selectedCell = [self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
	
	for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
		if (CGRectGetMidX(attributes.frame) == CGRectGetMidX(selectedCell.frame) && CGRectGetMidY(attributes.frame) == CGRectGetMidY(selectedCell.frame)) {
			CGSize s = attributes.size;
			s.height = 400;
			attributes.size  =s;
			CGRect r = attributes.frame;
			s = r.size;
			s.height = 400;
			r.size = s;
			r.origin.y += 100;
			attributes.frame = r;
			
//			CGPoint c = attributes.center;
//			c = CGPointMake(CGRectGetMidX(attributes.frame), CGRectGetMidY(attributes.frame));
//			attributes.center = c;
		}
		else if (CGRectGetMidY(attributes.frame) > CGRectGetMidY(selectedCell.frame)) {
			CGRect r = attributes.frame;
			r.origin.y += 100;
			attributes.frame = r;
			
		}
		DNSLogRect(attributes.frame);
	}
	}
	return attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

@end
