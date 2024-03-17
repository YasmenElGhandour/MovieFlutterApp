package com.example.movie_app_task

import androidx.activity.viewModels
import androidx.annotation.NonNull
import com.example.movie_app_task.viewmodel.MoviesViewModel
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


@AndroidEntryPoint
class MainActivity:  FlutterFragmentActivity() ,MethodChannel.MethodCallHandler {
    private val viewModel: MoviesViewModel by viewModels()

    private val CHANNEL = "com.example.movie_app_task/native"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(this)

    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if(call.method == "getDataFromNativeCode"){
            val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
            val apiKey = hashMap["apiKey"]
            apiKey?.let {
                viewModel.getMovies(it as String,result)

            }
        }
        else if (call.method == "getDetails"){
            val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
            val apiKey = hashMap["apiKey"]
            val movieId = hashMap["movieId"]
            apiKey?.let { apiKey
                movieId?.let { movieId
                    viewModel._detailsMovieResponse.value=null
                    viewModel.getDetailsMovie(movieId as Int ,apiKey as String,result)
                   }
            }

        }
        else{
            result.notImplemented()

        }
    }


}
