import org.jetbrains.compose.desktop.application.dsl.TargetFormat
import org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
  alias(libs.plugins.kotlinMultiplatform)
  alias(libs.plugins.androidApplication)
  alias(libs.plugins.composeMultiplatform)
  alias(libs.plugins.composeCompiler)
  alias(libs.plugins.kotlin.serialization)
}

kotlin {
  androidTarget {
    @OptIn(ExperimentalKotlinGradlePluginApi::class)
    compilerOptions {
      jvmTarget.set(JvmTarget.JVM_11)
    }
  }

  listOf(
    iosX64(),
    iosArm64(),
    iosSimulatorArm64()
  ).forEach { iosTarget ->
    iosTarget.binaries.framework {
      baseName = "ComposeApp"
      isStatic = true
    }
  }

  sourceSets {

    androidMain.dependencies {
      implementation(compose.preview)
      implementation(libs.androidx.activity.compose)
      implementation(libs.ktor.client.okhttp)
    }
    iosMain.dependencies {
      implementation(libs.ktor.client.darwin)
    }
    commonMain.dependencies {
      implementation(compose.runtime)
      implementation(compose.foundation)
      implementation(compose.material)
      implementation(compose.ui)
      implementation(compose.components.resources)
      implementation(compose.components.uiToolingPreview)
      implementation(libs.androidx.lifecycle.viewmodel)
      implementation(libs.androidx.lifecycle.runtime.compose)
      implementation(libs.ktor.client.core)
      implementation(libs.ktor.serialization.kotlinx.json)
      implementation(libs.ktor.client.content.negotiation)
      implementation(libs.kotlinx.coroutines.core)
      implementation(libs.kotlinx.serialization.json)
      implementation(libs.androidx.navigation.compose)
      implementation(libs.coil.compose)
      implementation(libs.coil.network.ktor)
    }
  }
}

android {
  namespace = "com.whackylabs.photoapp"
  compileSdk = libs.versions.android.compileSdk.get().toInt()

  defaultConfig {
    applicationId = "com.whackylabs.photoapp"
    minSdk = libs.versions.android.minSdk.get().toInt()
    targetSdk = libs.versions.android.targetSdk.get().toInt()
    versionCode = 1
    versionName = "1.0"
  }
  packaging {
    resources {
      excludes += "/META-INF/{AL2.0,LGPL2.1}"
    }
  }
  buildTypes {
    getByName("release") {
      isMinifyEnabled = false
    }
  }
  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }
}

dependencies {
  debugImplementation(compose.uiTooling)
}

