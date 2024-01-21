// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from photoapp.djinni

#pragma once

#include "djinni_support.hpp"
#include "photoapp.hpp"

namespace djinni_generated {

class NativePhotoapp final : ::djinni::JniInterface<::photoapp::Photoapp, NativePhotoapp> {
public:
    using CppType = std::shared_ptr<::photoapp::Photoapp>;
    using CppOptType = std::shared_ptr<::photoapp::Photoapp>;
    using JniType = jobject;

    using Boxed = NativePhotoapp;

    ~NativePhotoapp();

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::djinni::JniClass<NativePhotoapp>::get()._fromJava(jniEnv, j); }
    static ::djinni::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::djinni::JniClass<NativePhotoapp>::get()._toJava(jniEnv, c)}; }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
    NativePhotoapp();
    friend ::djinni::JniClass<NativePhotoapp>;
    friend ::djinni::JniInterface<::photoapp::Photoapp, NativePhotoapp>;

};

}  // namespace djinni_generated