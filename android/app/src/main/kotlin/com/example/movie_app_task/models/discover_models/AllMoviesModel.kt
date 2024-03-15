package com.example.movie_app_task.models.discover_models

data class AllMoviesModel(
    val page: Int,
    val results: List<AllMoviesResult>,
    val total_pages: Int,
    val total_results: Int
)