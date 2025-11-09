plugins {
    // nothing here — Flutter handles plugins in /app/build.gradle.kts
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Add Android build configuration here
extra.apply {
    set("compileSdkVersion", 34)
    set("targetSdkVersion", 34)
    set("minSdkVersion", 23)
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
