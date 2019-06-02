//
//  PhotoListViewDataSource.cpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#include "PhotoListViewDataSource.hpp"
#include <bdn/ui/yoga.h>
#include "PhotoCell.hpp"

using namespace bdn;


size_t PhotoListViewDataSource::numberOfRows()
{
    return 10;
}

std::shared_ptr<ui::View> PhotoListViewDataSource::viewForRowIndex(size_t rowIndex, std::shared_ptr<ui::View> reusableView)
{
    std::shared_ptr<PhotoCell> cell;
    if (reusableView) {
        cell = std::dynamic_pointer_cast<PhotoCell>(reusableView);
    } else {
        cell = std::make_shared<PhotoCell>();
        cell->build();
    }
    
    cell->text = "Cell" + std::to_string(rowIndex);
    
    return cell;
}

float PhotoListViewDataSource::heightForRowIndex(size_t rowIndex)
{
    return 100.0;
}
