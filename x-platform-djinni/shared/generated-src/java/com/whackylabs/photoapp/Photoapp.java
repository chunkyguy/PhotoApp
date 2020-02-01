// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from photoapp.djinni

package com.whackylabs.photoapp;

import java.util.concurrent.atomic.AtomicBoolean;

public abstract class Photoapp {
    public abstract String getPhotoapp();

    public static Photoapp create()
    {
        return CppProxy.create();
    }

    private static final class CppProxy extends Photoapp
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void _djinni_private_destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            _djinni_private_destroy();
            super.finalize();
        }

        @Override
        public String getPhotoapp()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getPhotoapp(this.nativeRef);
        }
        private native String native_getPhotoapp(long _nativeRef);

        public static native Photoapp create();
    }
}
