//
//  MyCollectionViewController.m
//  collection
//
//  Created by sonson on 2013/04/11.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "MyCollectionViewCell.h"
#import "MyFlowLayout.h"
#import "EditView.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	DNSLogMethod
	
	MyCollectionViewCell *selectedCell = (MyCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
	
	[self.collectionView performBatchUpdates:^{
		MyFlowLayout *layout = (MyFlowLayout*)self.collectionView.collectionViewLayout;
		if (layout.selectedIndexPath) {
			layout.selectedIndexPath = nil;
		}
		else {
			layout.selectedIndexPath = indexPath;
		}
		[layout invalidateLayout];
	} completion:^(BOOL success) {
		
		DNSLogRect(selectedCell.frame);
		DNSLogSize(collectionView.contentSize);
		if (selectedCell.frame.origin.y + selectedCell.frame.size.height + 100 == collectionView.contentSize.height) {
			[collectionView scrollRectToVisible:CGRectMake(0, collectionView.contentSize.height-1, 100, 100) animated:YES];
		}
	}];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	[collectionView reloadItemsAtIndexPaths:self.selectedRowIndexPaths];
	self.selectedRowIndexPaths = nil;
	self.selectedIndexPath = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	srand(time(0));
	
	NSMutableArray *images = [NSMutableArray array];
	
	for (int i = 0; i < 11; i++) {
		[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png", i]]];
	}
	for (int i = 0; i < 11; i++) {
		[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png", i]]];
	}
	
	self.cellHeights = [NSMutableArray array];
	for (int i = 0; i < [images count]; i++) {
		[self.cellHeights addObject:@(rand()%100 + 160)];
	}
	
	self.sections = [NSMutableArray array];
	
	[self.sections addObject:@{ @"title" : @"hoge01", @"images" : images }];
//	[self.sections addObject:@{ @"title" : @"hoge02", @"images" : images }];
	
	[self.collectionView reloadData];
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake([self.cellHeights[indexPath.item] floatValue], [self.cellHeights[indexPath.item] floatValue]);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSDictionary *info = self.sections[section];
	return [info[@"images"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	id obj = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
	return obj;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell2" forIndexPath:indexPath];
	
	NSDictionary *section = self.sections[indexPath.section];
	NSArray *images = section[@"images"];
	UIImage *image = images[indexPath.item];
	
//	NSLog(@"%@", cell);
//	NSLog(@"%@", cell.imageView);
	cell.imageView.image = image;
//	NSLog(@"%@", cell.imageView.image);
	
	if (self.selectedIndexPath) {
		if (indexPath.section == self.selectedIndexPath.section && indexPath.item == self.selectedIndexPath.item) {
			[cell addSubview:self.editView];
			CGRect r = self.editView.frame;
			r.origin.y = 200;
			self.editView.frame = r;
		}
	}
	
	return cell;
}

@end
