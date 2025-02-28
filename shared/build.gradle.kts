plugins {
    alias(libs.plugins.kotlin.cocoapods)
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.android.library)
}

kotlin {
    androidTarget {}
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        name = "CalculatorSample"
        summary = "Shared code for the calculator sample"
        homepage = "https://touchlab.co/"
        version = "1.0"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "CalculatorSample"
        }
    }

    sourceSets {

        commonTest.dependencies {
            implementation(kotlin("test"))
        }
        iosMain {
        }
        iosTest {
        }
    }
}

android {
    namespace = "co.touchlab.calculatorsample"
    compileSdk = 35
    defaultConfig {
        minSdk = 26
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }
}