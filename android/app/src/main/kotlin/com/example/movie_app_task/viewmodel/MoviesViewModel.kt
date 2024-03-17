package com.example.movie_app_task.viewmodel

import android.util.Log
import androidx.lifecycle.*
import com.example.movie_app_task.models.details_models.MovieDetailsModel
import com.example.movie_app_task.models.discover_models.AllMoviesModel
import com.example.movie_app_task.repository.MoviesRepository
import com.google.gson.Gson
import dagger.hilt.android.lifecycle.HiltViewModel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MoviesViewModel
@Inject
constructor(private val repository: MoviesRepository) : ViewModel() {

     val _discoverMoviesResponse = MutableLiveData<AllMoviesModel>()

     val _detailsMovieResponse = MutableLiveData<MovieDetailsModel>()


    fun getMovies(apiKey: String, result: MethodChannel.Result) = viewModelScope.launch {
        try {
            repository.getDiscoverMovies(apiKey)?.let { response ->
                if (response.isSuccessful) {
                    if(response.code() == 200 ){
                        _discoverMoviesResponse.postValue(response.body())
                        result.success(Gson().toJson(response.body()).toString())

                    }else{
                        result.error(response.code().toString(),"some thing went wrong",null)
                    }

                } else {
                    _discoverMoviesResponse.postValue(null)
                    result.error(response.code().toString(),"some thing went wrong",null)

                    Log.d("tag", "getAllMovies Error: ${response.code()}")

                }

            }
        }catch (e:Exception){

            Log.d("ExceptionError", "getAllMovies Error: ${e.cause.toString()}")
            _discoverMoviesResponse.postValue(null)
            result.error("600","some thing went wrong",null)

        }

    }

     fun getDetailsMovie(movieId:Int , apiKey:String,result: MethodChannel.Result) = viewModelScope.launch {
         try {
             repository.getMovieDetails(movieId , apiKey)?.let { response ->
                 if (response.isSuccessful) {
                     if(response.code() == 200 ){
                         _detailsMovieResponse.postValue(response.body())
                         result.success(Gson().toJson(response.body()).toString())

                     }else{
                         result.error(response.code().toString(),"some thing went wrong",null)
                     }

                 } else {
                     _detailsMovieResponse.postValue(null)
                     result.error(response.code().toString(),"some thing went wrong",null)

                     Log.d("tag", "getAllMovies Error: ${response.code()}")

                 }

             }
         }catch (e:Exception){

             Log.d("ExceptionError", "getAllMovies Error: ${e.cause.toString()}")
             _detailsMovieResponse.postValue(null)
             result.error("600","some thing went wrong",null)



         }

    }



}