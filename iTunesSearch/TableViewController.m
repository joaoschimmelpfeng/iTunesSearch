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
#import "Entidades/Midia.h"
#import "SearchView.h"
#import "showView.h"

@interface TableViewController () {
    NSArray *midias;
    
}

@end

@implementation TableViewController
@synthesize searchBar1;

iTunesManager *itunes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    [searchBar1 setDelegate:self];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *lastSearch = [def objectForKey:@"search"];
    if(lastSearch != NULL)
    {
        searchBar1.text = lastSearch;
    }
    
    itunes = [iTunesManager sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[midias objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Midia *filme;
     filme = [[midias objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.preco setText:[filme.preco stringValue]];
    [celula.tipo setText:NSLocalizedString(filme.tipo, nil)];
    [celula setViewTumb:filme.artWork];
    
    return celula;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    Midia *f = [[midias objectAtIndex:section] objectAtIndex:0];
    sectionName = NSLocalizedString(f.tipo, nil);
    
    return sectionName;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    midias = [itunes buscarMidias:searchBar.text];
    [self.tableview reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    showView *sview = [showView instance];
    Midia *f = [[midias objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    sview.media = f;
    [self.navigationController pushViewController:sview animated:YES];
    
    
}

- (IBAction)clicked:(id)sender
{
    [self searchBarSearchButtonClicked:searchBar1];
}
@end
