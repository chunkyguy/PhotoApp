//
//  PhotoCell.hpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#ifndef PhotoCell_hpp
#define PhotoCell_hpp
#include <bdn/foundation.h>
#include <bdn/ui.h>

class PhotoCell : public bdn::ui::CoreLess<bdn::ui::ContainerView> {
    
public:
    void build();
    bdn::Property<std::string> text;
};

#endif /* PhotoCell_hpp */
