plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.helloworldfiko"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.helloworldfiko"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Prevent macOS metadata files from being treated as Android resources
    packaging {
        resources {
            excludes += setOf("/**/._*", "/**/.DS_Store")
        }
    }
}

flutter {
    source = "../.."
}

// Workaround for macOS AppleDouble files created on non-APFS volumes (e.g., exFAT/NTFS)
// These files (like ._drawable-v21) can break AAPT2 resource parsing.
// We proactively delete them from the build intermediates before parse*LocalResources tasks run.
val removeAppleDouble by tasks.registering {
    group = "cleanup"
    description = "Remove AppleDouble (._*) and .DS_Store from intermediates to avoid AAPT2 failures"
    doLast {
        val roots = listOf(
            file("$buildDir/intermediates/packaged_res"),
            file("$buildDir"),
        )
        roots.filter { it.exists() }.forEach { root ->
            root.walkTopDown().forEach { f ->
                if (f.isFile && (f.name.startsWith("._") || f.name == ".DS_Store")) {
                    f.delete()
                }
            }
        }
    }
}

// Ensure cleanup happens before resource parsing tasks
tasks.matching { it.name.matches(Regex("parse.+LocalResources")) }.configureEach {
    dependsOn(removeAppleDouble)
}

// Also run cleanup after packaging resources, as these directories tend to get the AppleDouble files
tasks.matching { it.name.matches(Regex("package.+Resources")) }.configureEach {
    finalizedBy(removeAppleDouble)
}
