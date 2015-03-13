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
    NSUserDefaults *defaults;
    
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    midias = [[NSMutableArray alloc]init];
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
 
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@", [defaults objectForKey:@"BuscarPalavra"]);
    
    if ([[defaults objectForKey:@"BucarPalavra"] isEqual:@""])
    {
        midias = [itunes buscarMidias:@"Apple"];
        musicas = [itunes buscarMusica:@"Apple"];
        ebooks = [itunes buscarEboook:@"Apple"];
        podcasts = [itunes buscarPodcast:@"Apple"];
    }
    
    else
    {
        midias = [itunes buscarMidias:[defaults objectForKey:@"BuscarPalavra"]];
        musicas = [itunes buscarMusica:[defaults objectForKey:@"BuscarPalavra"]];
        ebooks = [itunes buscarEboook:[defaults objectForKey:@"BuscarPalavra"]];
        podcasts = [itunes buscarPodcast:[defaults objectForKey:@"BuscarPalavra"]];
    }
    
   
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
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    return [midias count];
    else if (section ==1)
        return [musicas count];
    else if (section ==2)
        return [ebooks count];
    else
        return [podcasts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    [self Armazenar];
    
    if (indexPath.section ==0)
        {
            Filme *filme = [midias objectAtIndex:indexPath.row];
            [celula.nome setText:filme.nome];
            [celula.tipo setText:filme.tipo];
            [celula.artista setText:filme.artista];
            NSString *a = [NSString stringWithFormat:@"%@",filme.duracao];
            [celula.duracao setText:a];
            [celula.genero setText:filme.genero];
      }
    
    if (indexPath.section ==1)
    {
        Musica *musica = [musicas objectAtIndex:indexPath.row];
        [celula.nome setText:musica.nome];
        [celula.tipo setText:musica.tipo];
        [celula.artista setText:musica.artista];
        NSString *a = [NSString stringWithFormat:@"%@",musica.duracao];
        [celula.duracao setText:a];
        [celula.genero setText:musica.genero];
    }
    
    if (indexPath.section ==2)
    {
        Ebook *ebook = [ebooks objectAtIndex:indexPath.row];
        [celula.nome setText:ebook.nome];
        [celula.tipo setText:ebook.tipo];
        [celula.artista setText:ebook.artista];
        NSString *a = [NSString stringWithFormat:@"%@",ebook.duracao];
        [celula.duracao setText:a];
        [celula.genero setText:ebook.genero];
    }
    
    if (indexPath.section ==3)
    {
        Podcast *podcast = [podcasts objectAtIndex:indexPath.row];
        [celula.nome setText:podcast.nome];
        [celula.tipo setText:podcast.tipo];
        [celula.artista setText:podcast.artista];
        NSString *a = [NSString stringWithFormat:@"%@",podcast.duracao];
        [celula.duracao setText:a];
        [celula.genero setText:podcast.genero];
    }
  
    return celula;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Filmes";
    else if (section ==1)
        return @"Musicas";
    else if (section ==2)
        return @"Ebooks";
    else
        return @"Podcast";
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
    
    [defaults setObject:_LTexto2.text forKey:@"BuscarPalavra"];
    
    
    
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
        musicas = [itunes buscarMusica:(_LTexto2.text)];
        ebooks = [itunes buscarEboook:(_LTexto2.text)];
        podcasts = [itunes buscarPodcast:(_LTexto2.text)];
        
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

