//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Midia.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    NSString *mediaTo = @"all";
    
    if (!termo) {
        termo = @"";
    }
    
    termo = [termo stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *expressao = @"(-music-)|(-movie-)";
    NSRegularExpression *ex1 = [NSRegularExpression regularExpressionWithPattern:expressao options:0 error:NULL];
    
    
    NSRange range1 = NSMakeRange(0, [termo length]);
    
    NSTextCheckingResult *match1 = [ex1 firstMatchInString:termo options:0 range:range1];
   
    
    
    NSString *result = [termo substringWithRange:[match1 rangeAtIndex:0]];
    
    
    NSLog(@"%@",result);
    
    if(match1 != nil)
    {
     if([result isEqualToString:@"-music-"])
     {
      mediaTo = @"music";
     }
     else if([result isEqualToString:@"-movie-"])
     {
      mediaTo = @"movie";
     }
    
     
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=%@", termo,mediaTo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *final = [[NSMutableArray alloc]init];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Midia *filme = [[Midia alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setArtWork:[item objectForKey:@"artworkUrl100"]];
        [filme setPreco:[item objectForKey:@"trackPrice"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setTipo:[item objectForKey:@"kind"]];
        
        
        
        
        if([filme.tipo isEqualToString:@"feature-movie"])
        {
         [filme setTipo:@"movie"];
         [filmes addObject:filme];
        }
        else if([filme.tipo isEqualToString:@"song"])
        {
         [musicas addObject:filme];
        }
    }
    
    if([filmes count] != 0)
    {
     [final addObject:filmes];
    }
    if([musicas count] != 0)
    {
     [final addObject:musicas];
    }
    return final;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
