package com.example.movie_app_task.viewmodel

import android.content.ContentValues.TAG
import android.util.Log
import androidx.annotation.MainThread
import androidx.lifecycle.*
import com.example.movie_app_task.models.details_models.MovieDetailsModel
import com.example.movie_app_task.models.discover_models.AllMoviesModel
import com.example.movie_app_task.repository.MoviesRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

@HiltViewModel
class MoviesViewModel
@Inject
constructor(private val repository: MoviesRepository) : ViewModel() {

    private val _discoverMoviesResponse = MutableLiveData<AllMoviesModel>()
    val responseDiscoverMovies: LiveData<AllMoviesModel>
        get() = _discoverMoviesResponse


     val _detailsMovieResponse = MutableLiveData<MovieDetailsModel>()
    val responseDetailsMovie: LiveData<MovieDetailsModel>
        get() = _detailsMovieResponse


    fun getMovies(apiKey: String) = viewModelScope.launch {
        repository.getDiscoverMovies(apiKey).let { response ->
            if (response.isSuccessful) {
                _discoverMoviesResponse.postValue(response.body())
                Log.d("Testviewmodel" , "${response.body()?.results?.get(0)}")

            } else {
                Log.d("tag", "getAllMovies Error: ${response.code()}")
            }
        }
    }

     fun getDetailsMovie(movieId:Int , apiKey:String) = viewModelScope.launch {
         repository.getMovieDetails(movieId = movieId, apiKey).let { response ->
            if (response.isSuccessful) {
                _detailsMovieResponse.postValue(response.body())
                  Log.d("yasmenmmmm" , "${response.body()?.title}")

            } else {
                Log.d("tag", "getAllMovies Error: ${response.code()}")
            }
        }
    }



}