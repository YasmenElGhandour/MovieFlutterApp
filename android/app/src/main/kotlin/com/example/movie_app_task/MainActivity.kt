package com.example.movie_app_task

import androidx.activity.viewModels
import androidx.annotation.NonNull
import androidx.lifecycle.viewModelScope
import com.example.movie_app_task.models.details_models.MovieDetailsModel
import com.example.movie_app_task.models.discover_models.AllMoviesModel
import com.example.movie_app_task.viewmodel.MoviesViewModel
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import dagger.hilt.android.ViewModelLifecycle
import dagger.hilt.android.scopes.ViewModelScoped
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import okhttp3.internal.wait


@AndroidEntryPoint
class MainActivity:  FlutterFragmentActivity()  {
    private val viewModel: MoviesViewModel by viewModels()

    private val CHANNEL = "com.example.movie_app_task/native"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method == "getDataFromNativeCode"){
                val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
                val apiKey = hashMap["apiKey"]
                apiKey?.let {
                     getAllMovies(result, it as String)

                }
            }else if (call.method == "getDetails"){
                val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
                val apiKey = hashMap["apiKey"]
                val movieId = hashMap["movieId"]
                apiKey.let { apiKey
                    movieId?.let { movieId
                     getMovieDetails(result , movieId as Int ,apiKey as String )

                    }
                }

            }
            else{
                result.notImplemented()

            }
        }
    }

    fun getAllMovies(result: MethodChannel.Result, apiKey : String) {
         viewModel.getMovies(apiKey)
        viewModel.responseDiscoverMovies.observe(this, { moviesResponse ->
            moviesResponse?.let {
                it
                if(it != null){
                        result.success(Gson().toJson(it).toString())

                }else{
                    result.error("error","error",null)
                }
            }
        })
    }

    fun getMovieDetails(result: MethodChannel.Result , movieId : Int,apiKey : String) {
        viewModel.getDetailsMovie(movieId,apiKey)
        var detailsResponse: MovieDetailsModel? = null
        viewModel.responseDetailsMovie.observe(this, { MovieDetailsResponse ->
            MovieDetailsResponse?.let {
                detailsResponse = it
                if(detailsResponse != null){
                        result.success(Gson().toJson(detailsResponse).toString())
                }else{
                    result.error("error","error",null)
                }
            }
        })

    }

    override fun onRestart() {
        super.onRestart()
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        println("kkkkkk")
    }

}
