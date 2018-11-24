//
//  photoappImpl.cpp
//  PhotoApp
//
//  Created by Sidharth Juyal on 24/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#include "photoappImpl.hpp"

using namespace photoapp;

std::shared_ptr<Photoapp> PhotoappImpl::create()
{
    return std::make_shared<PhotoappImpl>();
}

PhotoappImpl::PhotoappImpl()
{}

PhotoappImpl::~PhotoappImpl()
{}

std::string PhotoappImpl::get_photoapp()
{
    return "Photo App: version 0.1";
}
