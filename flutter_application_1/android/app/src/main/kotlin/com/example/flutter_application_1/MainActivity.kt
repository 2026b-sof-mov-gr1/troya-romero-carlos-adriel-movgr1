package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "recursos_android"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "obtenerRecursos") {

                val saludo = getString(R.string.saludo)
                val colorFondo = getColor(R.color.BackgroundColor)
                val colorTexto = getColor(R.color.TextColor)

                result.success(
                    mapOf(
                        "saludo" to saludo,
                        "colorFondo" to colorFondo,
                        "colorTexto" to colorTexto
                    )
                )

            } else {
                result.notImplemented()
            }
        }
    }
}