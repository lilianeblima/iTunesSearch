//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import <UIKit/UIKit.h>

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
    //TRATA O ERRO NAS FUNCOES
//    if (!termo) {
//        termo = @"";
//    }
//    
//    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
//    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
//    
//    NSError *error;
//    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:&error];
//    if (error) {
//        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
//        return nil;
//    }
//    
//    NSArray *resultados = [resultado objectForKey:@"results"];
//    NSMutableArray *filmes = [[NSMutableArray alloc] init];
//    
//    for (NSDictionary *item in resultados) {
//        Filme *filme = [[Filme alloc] init];
//        [filme setNome:[item objectForKey:@"trackName"]];
//        [filme setTrackId:[item objectForKey:@"trackId"]];
//        [filme setArtista:[item objectForKey:@"artistName"]];
//        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
//        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
//        [filme setPais:[item objectForKey:@"country"]];
//        [filmes addObject:filme];
//    }
//    
//    return filmes;
    
    //TRATA O ERRO NO OBJETO
    
        @try {
            if (!termo) {
                termo = @"";
            }
    
            NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
            NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
            NSError *error;
            NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
                return nil;
            }
    
            NSArray *resultados = [resultado objectForKey:@"results"];
            NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
            for (NSDictionary *item in resultados) {
                Filme *filme = [[Filme alloc] init];
                [filme setNome:[item objectForKey:@"trackName"]];
                [filme setTrackId:[item objectForKey:@"trackId"]];
                [filme setArtista:[item objectForKey:@"artistName"]];
                [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [filme setGenero:[item objectForKey:@"primaryGenreName"]];
                [filme setPais:[item objectForKey:@"country"]];
                [filmes addObject:filme];
                
            }
    return filmes;
        }
    
        @catch (NSException *exception) {
            NSMutableArray *filmes = nil;
            UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Erro de pesquisa" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [erro show];
            
            return filmes;
            NSLog(@"ERRO");
            
            
        }
      
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
