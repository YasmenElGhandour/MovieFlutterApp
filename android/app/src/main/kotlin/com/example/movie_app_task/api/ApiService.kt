package com.example.movie_app_task.api

import com.example.movie_app_task.helpers.Constants
import com.example.movie_app_task.models.details_models.MovieDetailsModel
import com.example.movie_app_task.models.discover_models.AllMoviesModel
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Headers
import retrofit2.http.Path

interface ApiService {

    @GET(Constants.MOVIES_END_POINT)
    suspend fun getMovies(@Path("api_key") apiKey: String):Response<AllMoviesModel>

    @GET(Constants.MOVIE_DETAILS_END_POINT)
    suspend fun getMovieDetails(@Path("movie_id") movieId: Int, @Path("api_key") apiKey: String):Response<MovieDetailsModel>

}