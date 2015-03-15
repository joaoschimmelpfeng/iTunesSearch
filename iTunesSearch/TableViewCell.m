//
//  TableViewCell.m
//  iTunesSearch
//
//  Created by Joao Schimmelpfeng
//  Copyright (c) 2015 Joao. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize imgView,imageIcon;

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


-(void) setImgIcon:(NSString *)tipo
{
 if([tipo isEqualToString:@"movie"])
 {
     UIImage *img = [UIImage imageNamed:@"Ifilme"];
     imageIcon.image = img;
 }
 else if([tipo isEqualToString:@"song"])
 {
  UIImage *img = [UIImage imageNamed:@"Imusic"];
  imageIcon.image = img;
 }
}

@end
