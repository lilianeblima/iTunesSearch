//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Podcast.h"
#import "Ebook.h"

@interface TableViewController () {
    NSArray *midias, *musicas, *ebooks, *podcasts, *recipes, *searchResult;
    NSMutableArray *armazena;
    
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    midias = [[NSMutableArray alloc]init];
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];
  
    musicas = [itunes buscarMusica:@"Apple"];
    ebooks = [itunes buscarEboook:@"Apple"];
    podcasts = [itunes buscarPodcast:@"Apple"];
    self.tableview.contentInset = UIEdgeInsetsMake(25.0f, 0.0f, 0.0f, 0.0);


    self.BBuscar.title = NSLocalizedString(@"botao", nil);
    
    
   // [self.Armazenar];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
   //  self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, self.tableview.bounds.size.width, 20)];

    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    [self Armazenar];
    
    
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    //if ([filme.tipo  isEqual: @"podcast"]) {
      
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:filme.tipo];
    [celula.artista setText:filme.artista];
    NSString *a = [NSString stringWithFormat:@"%@",filme.duracao];
    [celula.duracao setText:a];
    [celula.genero setText:filme.genero];
    
    NSLog(@"%@",midias);
    if (midias == nil) {
        NSLog(@"NIL");
    }
   // }
    return celula;
}



-(void)Armazenar
{
    int tamanho;
  //  tamanho = [midias.count] + [musicas.count] + [ebooks.count] + [podcasts.count];
    
    for (int i=0; i<midias.count; i++)
    {
        [armazena addObject:midias];
    }
    
    NSLog(@"%@",armazena);
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}



- (IBAction)BBuscar:(id)sender {
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    //TRATA O ERRO NO PROPRIO OBJETO ITUNES
//    iTunesManager *itunes = [iTunesManager sharedInstance];
//    midias = [itunes buscarMidias:(_LTexto2.text)];
//    
//    [_LTexto2 resignFirstResponder];
//    [self.tableview reloadData];
//    
    
    //TRATA O ERRO SOMENTE NESSA FUNCAO
    iTunesManager *itunes = [iTunesManager sharedInstance];

    @try {
        midias = [itunes buscarMidias:(_LTexto2.text)];
            [_LTexto2 resignFirstResponder];
        
        }
    @catch (NSException *exception) {
        NSLog(@"Nao foi possivel achar");
        [_LTexto2 setText:@""];
        _LTexto2.placeholder = NSLocalizedString(@"Erro! Tente novamente!", nil);
    }
    @finally {
           [self.tableview reloadData];
    }
    
    
    NSLog(@"Entrei");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_LTexto2 resignFirstResponder];
}
@end

