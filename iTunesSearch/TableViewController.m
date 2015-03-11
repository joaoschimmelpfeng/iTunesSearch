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
#import "SearchView.h"

@interface TableViewController () {
    NSArray *midias;
    
}

@end

@implementation TableViewController
@synthesize searchBar1,categorias;

iTunesManager *itunes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    [searchBar1 setDelegate:self];
    
    categorias = [[NSMutableArray alloc] init];
    
    itunes = [iTunesManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [categorias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.preco setText:[filme.preco stringValue]];
    [celula.tipo setText:NSLocalizedString(filme.tipo, nil)];
    [celula setViewTumb:filme.artWork];
    
    return celula;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    midias = [itunes buscarMidias:searchBar.text];
    Filme *f = [midias objectAtIndex:0];
    [categorias addObject:f.tipo];
    
    for(int i = 1; i < midias.count;i++)
    {
        Filme *filme = [midias objectAtIndex:i];
        for(int j = 0; j < categorias.count; j++)
        {
            if([filme.tipo  isEqualToString:[categorias objectAtIndex:j]])
            {
                break;
            }
            else
            {
                [categorias addObject:filme.tipo];
            }
        }
    }
    [self.tableview reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (IBAction)clicked:(id)sender
{
    [self searchBarSearchButtonClicked:searchBar1];
}
@end
