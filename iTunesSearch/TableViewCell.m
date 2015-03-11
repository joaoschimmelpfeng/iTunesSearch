//
//  TableViewCell.m
//  iTunesSearch
//
//  Created by Joao Schimmelpfeng
//  Copyright (c) 2015 Joao. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize imgView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setViewTumb:(NSString *)url
{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    imgView.image = image;
}

@end
