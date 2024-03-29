// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from photoapp.djinni

#include "NativePhotoapp.hpp"  // my header
#include "Marshal.hpp"

namespace djinni_generated {

NativePhotoapp::NativePhotoapp() : ::djinni::JniInterface<::photoapp::Photoapp, NativePhotoapp>("com/whackylabs/photoapp/Photoapp$CppProxy") {}

NativePhotoapp::~NativePhotoapp() = default;


CJNIEXPORT void JNICALL Java_com_whackylabs_photoapp_Photoapp_00024CppProxy_nativeDestroy(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        delete reinterpret_cast<::djinni::CppProxyHandle<::photoapp::Photoapp>*>(nativeRef);
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jobject JNICALL Java_com_whackylabs_photoapp_Photoapp_00024CppProxy_create(JNIEnv* jniEnv, jobject /*this*/)
{
    try {
        DJINNI_FUNCTION_PROLOGUE0(jniEnv);
        auto r = ::photoapp::Photoapp::create();
        return ::djinni::release(::djinni_generated::NativePhotoapp::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_com_whackylabs_photoapp_Photoapp_00024CppProxy_native_1getPhotoapp(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::photoapp::Photoapp>(nativeRef);
        auto r = ref->get_photoapp();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

}  // namespace djinni_generated
