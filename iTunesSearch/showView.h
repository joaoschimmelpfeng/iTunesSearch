//
//  showView.h
//  iTunesSearch
//
//  Created by João Vitor dos Santos Schimmelpfeng on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Midia.h"

@interface showView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *preco;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property Midia *media;
+(showView *)instance;

@end
