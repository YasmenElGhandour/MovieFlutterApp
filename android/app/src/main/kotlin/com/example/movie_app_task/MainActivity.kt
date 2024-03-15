package com.example.movie_app_task


import androidx.activity.viewModels
import androidx.annotation.NonNull
import com.example.movie_app_task.helpers.Constants
import com.example.movie_app_task.models.details_models.MovieDetailsModel
import com.example.movie_app_task.models.discover_models.AllMoviesModel
import com.example.movie_app_task.viewmodel.MoviesViewModel
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

@AndroidEntryPoint
class MainActivity:  FlutterFragmentActivity()  {
    private val viewModel: MoviesViewModel by viewModels()

    private val CHANNEL = "com.example.movie_app_task/native"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method == "getDataFromNativeCode"){
                getAllMovies(result)
            }
            else if (call.method == "getDetails"){
                val hashMap = call.arguments as HashMap<*,*> //Get the arguments as a HashMap
                val movieId = hashMap["movieId"]
                movieId?.let {
                    getMovieDetails(result , it as Int)
                }

            } else{
                result.notImplemented()
            }

        }
    }

    fun getAllMovies(result: MethodChannel.Result): AllMoviesModel? {
         viewModel.getMovies(Constants.API_KEY)
        var response: AllMoviesModel? = null
        viewModel.responseDiscoverMovies.observe(this, { moviesResponse ->
            moviesResponse?.let {
                response = it
                if(response != null){
                    result.success(Gson().toJson(response).toString())
                }else{
                    result.error("400","not found",null)
                }
            }
        })
        return response
    }

    fun getMovieDetails(result: MethodChannel.Result , movieId : Int): MovieDetailsModel? {
        viewModel.getDetailsMovie(movieId =movieId )
        var detailsResponse: MovieDetailsModel? = null
        viewModel.responseDetailsMovie.observe(this, { MovieDetailsResponse ->
            MovieDetailsResponse?.let {
                detailsResponse = it
                if(detailsResponse != null){
                    result.success(Gson().toJson(detailsResponse).toString())
                }else{
                    result.error("400","not found",null)
                }
            }
        })
        return detailsResponse
    }

}
