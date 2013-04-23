//
//  MyCollectionViewController.m
//  collection
//
//  Created by sonson on 2013/04/11.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "MyCollectionViewCell.h"
#import "ClickableFlowLayout.h"
#import "AlignWithTopFlowLayout.h"
#import "AlignWithBottomFlowLayout.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (IBAction)selectLayout:(id)sender {
	UISegmentedControl *control = (UISegmentedControl*)sender;
	
	switch(control.selectedSegmentIndex) {
		case 0:
			[self.collectionView setCollectionViewLayout:[[ClickableFlowLayout alloc] init] animated:YES];
			break;
		case 1:
			[self.collectionView setCollectionViewLayout:[[AlignWithTopFlowLayout alloc] init] animated:YES];
			break;
		case 2:
			[self.collectionView setCollectionViewLayout:[[AlignWithBottomFlowLayout alloc] init] animated:YES];
			break;
	}
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	DNSLogMethod
	
	UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
	
	if ([collectionView.collectionViewLayout isKindOfClass:[ClickableFlowLayout class]]) {
		MyCollectionViewCell *selectedCell = (MyCollectionViewCell*)cell;
		
		[self.collectionView performBatchUpdates:^{
			ClickableFlowLayout *layout = (ClickableFlowLayout*)self.collectionView.collectionViewLayout;
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
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	srand(time(0));
	
	NSMutableArray *images = [NSMutableArray array];
	
	for (int i = 0; i < 11; i++)
		[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png", i]]];
	for (int i = 0; i < 11; i++)
		[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png", i]]];
	
	NSMutableArray *cellHeights = [NSMutableArray array];
	for (int i = 0; i < [images count]; i++)
		[cellHeights addObject:@(rand()%100 + 160)];
	
	self.sections = [NSMutableArray array];
	
	[self.sections addObject:@{ @"title" : @"hoge01", @"images" : images, @"height": cellHeights}];
	[self.sections addObject:@{ @"title" : @"hoge02", @"images" : images, @"height": cellHeights}];
	
	[self.collectionView reloadData];
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *info = self.sections[indexPath.section];
	NSMutableArray *cellHeights = info[@"height"];
	return CGSizeMake([cellHeights[indexPath.item] floatValue], [cellHeights[indexPath.item] floatValue]);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSDictionary *info = self.sections[section];
	return [info[@"images"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self.sections count];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	id obj = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
	return obj;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
	
	NSDictionary *section = self.sections[indexPath.section];
	NSArray *images = section[@"images"];
	UIImage *image = images[indexPath.item];
	
	cell.imageView.image = image;
	
	return cell;
}

@end
