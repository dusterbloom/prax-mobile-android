package expo.modules.penumbrasdkmodule

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.kotlin.Promise
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.mobile.*

class PenumbraSdkModule : Module() {
    private val scope = CoroutineScope(Dispatchers.Default)

    override fun definition() = ModuleDefinition {
        Name("PenumbraSdkModule")

        /*
        View(MyModuleView::class) {
            Prop("name") { view: MyModuleView, name: String ->
            }
        }
        */

        
        // Penumbra SDK functions
        AsyncFunction("createAppStateContainer") { promise: Promise ->
            scope.launch {
                try {
                    val result = createAppStateContainer()
                    promise.resolve(result)
                } catch (e: AppException) {
                    promise.reject("APP_ERROR", e.message, e)
                }
            }
        }

        AsyncFunction("startServer") { promise: Promise ->
            scope.launch {
                try {
                    val result = startServer()
                    promise.resolve(result)
                } catch (e: AppException) {
                    promise.reject("SERVER_ERROR", e.message, e)
                }
            }
        }

        AsyncFunction("getBlockHeight") { promise: Promise ->
            scope.launch {
                try {
                    val result = getBlockHeight()
                    promise.resolve(result.toString())
                } catch (e: AppException) {
                    promise.reject("BLOCK_HEIGHT_ERROR", e.message, e)
                }
            }
        }
    }
}