//
//  DoneViewController.h
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegate.h"

@interface DoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate , Delegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addBarBtn:(id)sender;
@end

