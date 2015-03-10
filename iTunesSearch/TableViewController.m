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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    [searchBar1 setDelegate:self];
    
    itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Alien"];
    
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
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula setViewTumb:filme.artWork];
    
    return celula;
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
    midias = [itunes buscarMidias:searchBar1.text];
    [self.tableview reloadData];
}
@end
