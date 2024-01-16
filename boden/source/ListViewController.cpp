//
//  ListViewController.cpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#include "ListViewController.hpp"

#include <bdn/ui/yoga.h>

using namespace bdn;

ListViewController::ListViewController() :
_listView(std::make_shared<ui::ListView>()),
_dataSource(std::make_shared<PhotoListViewDataSource>())
{
    _listView->enableRefresh = true;
    _listView->stylesheet = FlexJsonStringify({
        "direction" : "Column",
        "flexGrow" : 1.0,
        "flexShrink" : 1.0
    });
    
    
    _listView->onRefresh() += [this]() {
        reloadData();
    };
    
    _listView->dataSource = _dataSource;    
}

void ListViewController::reloadData()
{
    _listView->reloadData();
    _listView->refreshDone();
}
