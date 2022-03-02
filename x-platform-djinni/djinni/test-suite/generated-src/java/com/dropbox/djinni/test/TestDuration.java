// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from duration.djinni

package com.dropbox.djinni.test;

import java.util.concurrent.atomic.AtomicBoolean;
import javax.annotation.CheckForNull;
import javax.annotation.Nonnull;

public interface TestDuration {
    @Nonnull
    public static String hoursString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.hoursString(dt);
    }

    @Nonnull
    public static String minutesString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.minutesString(dt);
    }

    @Nonnull
    public static String secondsString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.secondsString(dt);
    }

    @Nonnull
    public static String millisString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.millisString(dt);
    }

    @Nonnull
    public static String microsString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.microsString(dt);
    }

    @Nonnull
    public static String nanosString(@Nonnull java.time.Duration dt)
    {
        return CppProxy.nanosString(dt);
    }

    @Nonnull
    public static java.time.Duration hours(int count)
    {
        return CppProxy.hours(count);
    }

    @Nonnull
    public static java.time.Duration minutes(int count)
    {
        return CppProxy.minutes(count);
    }

    @Nonnull
    public static java.time.Duration seconds(int count)
    {
        return CppProxy.seconds(count);
    }

    @Nonnull
    public static java.time.Duration millis(int count)
    {
        return CppProxy.millis(count);
    }

    @Nonnull
    public static java.time.Duration micros(int count)
    {
        return CppProxy.micros(count);
    }

    @Nonnull
    public static java.time.Duration nanos(int count)
    {
        return CppProxy.nanos(count);
    }

    @Nonnull
    public static java.time.Duration hoursf(double count)
    {
        return CppProxy.hoursf(count);
    }

    @Nonnull
    public static java.time.Duration minutesf(double count)
    {
        return CppProxy.minutesf(count);
    }

    @Nonnull
    public static java.time.Duration secondsf(double count)
    {
        return CppProxy.secondsf(count);
    }

    @Nonnull
    public static java.time.Duration millisf(double count)
    {
        return CppProxy.millisf(count);
    }

    @Nonnull
    public static java.time.Duration microsf(double count)
    {
        return CppProxy.microsf(count);
    }

    @Nonnull
    public static java.time.Duration nanosf(double count)
    {
        return CppProxy.nanosf(count);
    }

    @CheckForNull
    public static java.time.Duration box(long count)
    {
        return CppProxy.box(count);
    }

    public static long unbox(@CheckForNull java.time.Duration dt)
    {
        return CppProxy.unbox(dt);
    }

    static final class CppProxy implements TestDuration
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

        @Nonnull
        public static native String hoursString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native String minutesString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native String secondsString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native String millisString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native String microsString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native String nanosString(@Nonnull java.time.Duration dt);

        @Nonnull
        public static native java.time.Duration hours(int count);

        @Nonnull
        public static native java.time.Duration minutes(int count);

        @Nonnull
        public static native java.time.Duration seconds(int count);

        @Nonnull
        public static native java.time.Duration millis(int count);

        @Nonnull
        public static native java.time.Duration micros(int count);

        @Nonnull
        public static native java.time.Duration nanos(int count);

        @Nonnull
        public static native java.time.Duration hoursf(double count);

        @Nonnull
        public static native java.time.Duration minutesf(double count);

        @Nonnull
        public static native java.time.Duration secondsf(double count);

        @Nonnull
        public static native java.time.Duration millisf(double count);

        @Nonnull
        public static native java.time.Duration microsf(double count);

        @Nonnull
        public static native java.time.Duration nanosf(double count);

        @CheckForNull
        public static native java.time.Duration box(long count);

        public static native long unbox(@CheckForNull java.time.Duration dt);
    }
}