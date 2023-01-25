package co.touchlab.calculatorsample

sealed class OperationType {
    data class UNKNOWN(val message: String) : OperationType()
    object PLUS : OperationType()
    object MINUS : OperationType()
    object DIVIDE : OperationType()
    object MULTIPLY : OperationType()
    object CLEAR : OperationType()
    object DELETE : OperationType()
    object EQUALS : OperationType()
}

fun lookupOperationType(
    value: String,
    defaultValue: OperationType = OperationType.UNKNOWN("Oops")
) = when (value) {
    "+" -> OperationType.PLUS
    "-" -> OperationType.MINUS
    "/" -> OperationType.DIVIDE
    "*" -> OperationType.MULTIPLY
    "C" -> OperationType.CLEAR
    "<" -> OperationType.DELETE
    "=" -> OperationType.EQUALS
    else -> defaultValue
}
