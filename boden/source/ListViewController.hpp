//
//  ListViewController.hpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#ifndef ListViewController_hpp
#define ListViewController_hpp

#include <bdn/ui.h>
#include "PhotoListViewDataSource.hpp"

class ListViewController {
public:
    ListViewController();
    std::shared_ptr<bdn::ui::View> view();
    
private:
    
    void reloadData();
    
    std::shared_ptr<bdn::ui::ListView> _listView;
    std::shared_ptr<PhotoListViewDataSource> _dataSource;
};

inline
std::shared_ptr<bdn::ui::View> ListViewController::view()
{
    return _listView;
}

#endif /* ListViewController_hpp */
