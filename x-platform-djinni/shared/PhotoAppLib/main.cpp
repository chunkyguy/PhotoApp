//
//  main.cpp
//  PhotoAppLib
//
//  Created by Sidharth Juyal on 24/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#include <iostream>
#include "photoappImpl.hpp"

int main(int argc, const char * argv[])
{
    auto app = photoapp::PhotoappImpl::create();
    std::cout << app->get_photoapp() << std::endl;
    return 0;
}
