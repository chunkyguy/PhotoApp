// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from photoapp.djinni

#pragma once

#include <memory>
#include <string>

namespace photoapp {

class Photoapp {
public:
    virtual ~Photoapp() {}

    static std::shared_ptr<Photoapp> create();

    virtual std::string get_photoapp() = 0;
};

}  // namespace photoapp
