//
//  PhotoListViewDataSource.hpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#ifndef ListViewDataSource_hpp
#define ListViewDataSource_hpp

#include <bdn/ui.h>

class PhotoListViewDataSource : public bdn::ui::ListViewDataSource {
public:    

    size_t numberOfRows() override;

    std::shared_ptr<bdn::ui::View> viewForRowIndex(size_t rowIndex, std::shared_ptr<bdn::ui::View> reusableView) override;

    float heightForRowIndex(size_t rowIndex) override;
};

#endif /* ListViewDataSource_hpp */
