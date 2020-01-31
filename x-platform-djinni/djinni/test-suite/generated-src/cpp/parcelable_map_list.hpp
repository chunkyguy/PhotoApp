// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from parcelable.djinni

#pragma once

#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

namespace testsuite {

struct ParcelableMapList final {
    std::unordered_map<std::string, std::vector<std::string>> map_set;

    ParcelableMapList(std::unordered_map<std::string, std::vector<std::string>> map_set_)
    : map_set(std::move(map_set_))
    {}
};

}  // namespace testsuite
