package com.example.movie_app_task.di

import android.content.Context
import com.example.movie_app_task.api.ApiService
import com.example.movie_app_task.helpers.Constants
import com.example.movie_app_task.repository.MoviesRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import okhttp3.Cache
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {


    @Provides
    fun provideBaseUrl() = Constants.BASE_URL

    val cacheSize =
        (5 * 1024 * 1024).toLong() // 5 MB cache size, because we like to keep things moderate
    val cachingInterceptor = Interceptor { chain ->
        val originalResponse = chain.proceed(chain.request())
        val cacheControl = originalResponse.header("Cache-Control")
        if (cacheControl == null || cacheControl.contains("no-store") || cacheControl.contains("no-cache") ||
            cacheControl.contains("must-revalidate") || cacheControl.contains("max-age=0")
        ) {
            // No cache headers, skip caching
            originalResponse
        } else {
            val maxAge = 60 // Cache for 1 minute, because patience is not always a virtue
            originalResponse.newBuilder()
                .header("Cache-Control", "public, max-age=$maxAge")
                .build()
        }
    }

    @Provides
    @Singleton
    fun provideRetrofitInstance(
        BASE_URL: String,
        @ApplicationContext context: Context
    ): ApiService =
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .client(
                OkHttpClient.Builder()
//                    .addInterceptor { chain ->
//                        val request = chain.request().newBuilder()
//                            .addHeader("Authorization", "Bearer ${Constants.TOKEN}").build()
//                        chain.proceed(request)
//                    }
                    .cache(Cache(context.cacheDir, cacheSize)).addInterceptor(cachingInterceptor)
                    .build())
            .build()
            .create(ApiService::class.java)

    @Provides
    @Singleton
    fun provideMoviesRepository(apiService: ApiService): MoviesRepository =
        MoviesRepository(apiService)
}