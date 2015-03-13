//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Ebook.h"
#import "Podcast.h"
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
    
    //TRATA O ERRO NO OBJETO
     //BUSCAR UM TIPO DE CADA VEZ
         NSMutableArray *filmes = [[NSMutableArray alloc] init];

    
           
            if (!termo) {
                termo = @"";
            }
    
            NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
            NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
            

            NSError *error;
            NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
                return nil;
            }
    
            NSArray *resultados = [resultado objectForKey:@"results"];


    
            for (NSDictionary *item in resultados) {
                Filme *filme = [[Filme alloc] init];
                [filme setNome:[item objectForKey:@"trackName"]];
                [filme setTrackId:[item objectForKey:@"trackId"]];
                [filme setArtista:[item objectForKey:@"artistName"]];
                [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [filme setGenero:[item objectForKey:@"primaryGenreName"]];
                [filme setPais:[item objectForKey:@"country"]];
                [filme setTipo:[item objectForKey:@"kind"]];
                [filmes addObject:filme];
          
            }
            return filmes;
     
      
}


- (NSArray *)buscarMusica:(NSString *)termo
{
    @try {
        if (!termo) {
            termo = @"";
        }
        
            NSString *url1 = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
            NSData *jsonData1 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url1]];
            
            
    
        NSError *error;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData1 options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *musicas = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Musica *musica = [[Musica alloc] init];
            [musica setNome:[item objectForKey:@"trackName"]];
            [musica setTrackId:[item objectForKey:@"trackId"]];
            [musica setArtista:[item objectForKey:@"artistName"]];
            [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [musica setGenero:[item objectForKey:@"primaryGenreName"]];
            [musica setPais:[item objectForKey:@"country"]];
            [musicas addObject:musica];
            
            
            
        }
        return musicas;
        
    }
    
    @catch (NSException *exception)
    {

        NSMutableArray *musicas = nil;
        UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Erro de pesquisa" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erro show];
        return  musicas;
        NSLog(@"ERRO");
    }

}

- (NSArray *)buscarPodcast:(NSString *)termo
{
    @try {
        if (!termo) {
            termo = @"";
        }
        
        NSString *url2 = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast", termo];
        NSData *jsonData2 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url2]];
        
        
        NSError *error;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData2 options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *podcasts = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Podcast *podcast = [[Podcast alloc] init];
            [podcast setNome:[item objectForKey:@"trackName"]];
            [podcast setTrackId:[item objectForKey:@"trackId"]];
            [podcast setArtista:[item objectForKey:@"artistName"]];
            [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
            [podcast setPais:[item objectForKey:@"country"]];
            [podcasts addObject:podcast];
            
            
            
            
        }
        return podcasts;
        
    }
    
    @catch (NSException *exception)
    {
        
        NSMutableArray *podcasts = nil;
        UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Erro de pesquisa" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erro show];
        return  podcasts;
        NSLog(@"ERRO");
    }
    
}

- (NSArray *)buscarEboook:(NSString *)termo
{
    @try {
        if (!termo) {
            termo = @"";
        }
        
        NSString *url3 = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=ebook", termo];
        NSData *jsonData3 = [NSData dataWithContentsOfURL: [NSURL URLWithString:url3]];
        
        
        NSError *error;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData3 options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *ebooks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Ebook *ebook = [[Ebook alloc] init];
            [ebook setNome:[item objectForKey:@"trackName"]];
            [ebook setTrackId:[item objectForKey:@"trackId"]];
            [ebook setArtista:[item objectForKey:@"artistName"]];
            [ebook setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
            [ebook setPais:[item objectForKey:@"country"]];
            [ebooks addObject:ebook];
            
            
        }
        return ebooks;
        
    }
    
    @catch (NSException *exception)
    {
        
        NSMutableArray *ebooks = nil;
        UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Erro de pesquisa" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erro show];
        return  ebooks;
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
