package com.example.movie_app_task

import android.util.Log
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

    fun getAllMovies(result: MethodChannel.Result, apiKey : String) {
        viewModel.getMovies(apiKey)
        viewModel.responseDiscoverMovies.observe(this, { moviesResponse ->
            moviesResponse?.let {
                if(it != null && viewModel.responseCode == 200 ){
                    result.success(Gson().toJson(it).toString())

                }else{
                    result.error(viewModel.responseCode.toString(),"some thing went wrong",null)
                }
            }
        })
    }

    fun getMovieDetails(result: MethodChannel.Result, movieId : Int, apiKey : String) {
        var setResult=true
        viewModel._detailsMovieResponse.value=null
        viewModel.getDetailsMovie(movieId,apiKey)
        viewModel.responseDetailsMovie.observe(this, { MovieDetailsResponse ->
            MovieDetailsResponse?.let {
               if(setResult && it != null && viewModel.responseCode == 200 ){
                   result.success(Gson().toJson(it).toString())
                   setResult=false
               }else{
                   result.error(viewModel.responseCode.toString(),"some thing went wrong",null)
               }

            }
        })


    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if(call.method == "getDataFromNativeCode"){
            val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
            val apiKey = hashMap["apiKey"]
            apiKey?.let {
                     getAllMovies(result, it as String)

            }
        }
        else if (call.method == "getDetails"){
            val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
            val apiKey = hashMap["apiKey"]
            val movieId = hashMap["movieId"]
            apiKey?.let { apiKey
                movieId?.let { movieId
                       getMovieDetails(result, movieId as Int ,apiKey as String )
                   }
            }

        }
        else{
            result.notImplemented()

        }
    }


}
