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
@synthesize searchBar1;

iTunesManager *itunes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    [searchBar1 setDelegate:self];
    
    itunes = [iTunesManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Tempo : %lu",section);
    return [[midias objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme;
    
    if(indexPath.section == 0)
    {
     filme = [[midias objectAtIndex:0] objectAtIndex:indexPath.row];
    }
    else
    {
     filme = [[midias objectAtIndex:1] objectAtIndex:indexPath.row];
    }
    
    [celula.nome setText:filme.nome];
    [celula.preco setText:[filme.preco stringValue]];
    [celula.tipo setText:NSLocalizedString(filme.tipo, nil)];
    [celula setViewTumb:filme.artWork];
    
    return celula;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    Filme *f = [[midias objectAtIndex:section] objectAtIndex:0];
    sectionName = NSLocalizedString(f.tipo, nil);
    
    return sectionName;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    midias = [itunes buscarMidias:searchBar.text];
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
