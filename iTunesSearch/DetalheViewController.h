//
//  DetalheViewController.h
//  iTunesSearch
//
//  Created by Liliane Bezerra Lima on 15/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalheViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ILogo;
@property (weak, nonatomic) IBOutlet UIImageView *IImagem;
@property (weak, nonatomic) IBOutlet UILabel *LTitulo;
@property (weak, nonatomic) IBOutlet UILabel *LTipo;
@property (weak, nonatomic) IBOutlet UILabel *LGenero;
@property (weak, nonatomic) IBOutlet UILabel *LArtista;

@end
