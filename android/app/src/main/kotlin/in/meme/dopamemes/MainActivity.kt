
package `in`.meme.dopamemes

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.PersistableBundle
import com.google.common.net.MediaType
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.net.URLConnection

class MainActivity: FlutterActivity() {

    var recieveIntentDataMethodChannel:MethodChannel?=null



    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        var recievedIntent = intent


        recieveIntentDataMethodChannel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "receivedIntent")

        recieveIntentDataMethodChannel?.setMethodCallHandler { call, result ->

            if(call.method.contentEquals("receivedIntent")&&intent!==null)
            {
                var map = HashMap<String,String>()
                map["type"] = intent.type
                map["fileType"] = getMediaType(intent)
                map["path"] = getMediaUris(intent).toString()
                result.success(map)
            }
        }


    }


    private fun getMediaType(path: Intent?): String {
        if(intent.type.contains("text",true))
            return "text"

        val mimeType = URLConnection.guessContentTypeFromName(getMediaUris(intent))
        return when {
            mimeType?.startsWith("image") == true -> "image"
            mimeType?.startsWith("video") == true -> "video"
            else -> "unknown"
        }
    }



    private fun getMediaUris(intent: Intent?): String? {
        if (intent == null) return ""

        if(intent.type.contains("text",true))
            return intent.getStringExtra(Intent.EXTRA_TEXT)

        return if (intent.action==Intent.ACTION_SEND) {

            val uri = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
            FileDirectory.getAbsolutePath(applicationContext, uri)
        }else{
            ""
        }
            }


    
}
