package com.qader.firststep

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL
import kotlin.concurrent.thread

class OfflineService : Service() {
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("OfflineService", "Started")
        return START_NOT_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        val token = rootIntent?.getStringExtra("auth_token") ?: MainActivity.userToken

        thread {
            try {
                val url = URL("https://your-api.com/offline")
                val connection = url.openConnection() as HttpURLConnection
                connection.requestMethod = "POST"
                connection.doOutput = true
                connection.setRequestProperty("Content-Type", "application/json")

                if (token != null) {
                    connection.setRequestProperty("Authorization", "Bearer $token")
                }

                val writer = OutputStreamWriter(connection.outputStream)
                writer.write("{}")
                writer.flush()
                writer.close()

                connection.responseCode // Triggers request
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        stopSelf()
        super.onTaskRemoved(rootIntent)
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
