//
//  showView.m
//  iTunesSearch
//
//  Created by João Vitor dos Santos Schimmelpfeng on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "showView.h"
#import "Midia.h"

@interface showView ()

@end

@implementation showView
@synthesize media,imageView,titulo,artista,preco,genero;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    artista.text = media.artista;
    titulo.text = media.nome;
    preco.text = [media.preco stringValue];
    genero.text = media.genero;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: media.artWork]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    imageView.image = image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (showView *)instance
{
    static showView *sharedContador = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedContador = [[self alloc] init];
                  });
    return sharedContador;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
