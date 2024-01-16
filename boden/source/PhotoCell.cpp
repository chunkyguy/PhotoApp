//
//  PhotoCell.cpp
//  DemoBoden
//
//  Created by chunkyguy on 02/06/2019.
//

#include "PhotoCell.hpp"
#include <bdn/ui/yoga.h>

using namespace bdn;

void PhotoCell::build()
{
    stylesheet = FlexJsonStringify({
        "direction" : "Row",
        "flexGrow" : 1.0,
        "justifyContent" : "SpaceBetween",
        "alignItems" : "FlexStart",
        "padding" : {"all" : 2.5}
    });
    
    auto label = std::make_shared<ui::Label>();
    label->stylesheet = FlexJsonStringify({
        "alignSelf": "Center",
        "flexGrow" : 1.0
    });
    label->text.bind(text);
    addChildView(label);
}
