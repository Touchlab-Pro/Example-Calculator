package co.touchlab.calculatorsample

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform