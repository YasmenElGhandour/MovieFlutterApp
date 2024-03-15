package com.example.movie_app_task.repository


import com.example.movie_app_task.api.ApiService
import javax.inject.Inject

class MoviesRepository @Inject constructor(private val apiService: ApiService) {
    suspend fun getDiscoverMovies(apiKey: String) = apiService.getMovies(apiKey = apiKey)
    suspend fun getMovieDetails(movieId: Int) = apiService.getMovieDetails(movieId = movieId)

}
