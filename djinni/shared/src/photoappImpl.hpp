//
//  photoappImpl.hpp
//  PhotoApp
//
//  Created by Sidharth Juyal on 24/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#ifndef photoappImpl_hpp
#define photoappImpl_hpp

#include "photoapp.hpp"

namespace photoapp {
    class PhotoappImpl: public Photoapp {
    public:
        PhotoappImpl();
        virtual ~PhotoappImpl();
        virtual std::string get_photoapp();
    };
}

#endif /* photoappImpl_hpp */
