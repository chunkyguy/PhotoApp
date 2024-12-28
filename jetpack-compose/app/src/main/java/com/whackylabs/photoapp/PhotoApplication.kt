package com.whackylabs.photoapp

import android.app.Application

class PhotoApplication : Application() {
  lateinit var container: AppContainer
  override fun onCreate() {
    super.onCreate()
    container = AppContainerImpl()
  }
}