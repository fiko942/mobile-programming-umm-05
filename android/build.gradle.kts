allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Allow overriding the Gradle build directory to an APFS location to avoid AppleDouble (._) files on external drives
val buildDirOverride: String? = System.getenv("GRADLE_BUILD_DIR_OVERRIDE")
    ?: System.getProperty("gradle.build.dir.override")

if (!buildDirOverride.isNullOrBlank()) {
    // Set build output outside the project (e.g., on APFS under $HOME)
    rootProject.buildDir = file(buildDirOverride)
    subprojects {
        buildDir = file("${rootProject.buildDir}/${project.name}")
    }
} else {
    // Keep the existing custom layout under the repo root ../../build
    val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
    rootProject.layout.buildDirectory.value(newBuildDir)
    subprojects {
        project.layout.buildDirectory.value(newBuildDir.dir(project.name))
    }
}
