package com.whackylabs.photoapp

import android.content.Intent
import android.os.Bundle
import android.widget.GridView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {

    private val viewModel: PhotoListViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.state.collect { state ->
                    when (state) {
                        is PhotoListViewModel.State.Loading -> showLoading()
                        is PhotoListViewModel.State.Error -> showError(state.message)
                        is PhotoListViewModel.State.Content -> showPhotoList(state.photos)
                    }
                }
            }
        }
        viewModel.fetchPhotos()
    }

    private fun showLoading() {
        Toast
            .makeText(this, "Loading ...", Toast.LENGTH_LONG)
            .show()
    }

    private fun showError(message: String) {
        Toast
            .makeText(this, message, Toast.LENGTH_LONG)
            .show()
    }

    private fun showPhotoList(photos: List<Photo>) {
        val gridVw = findViewById<GridView>(R.id.gridVw)

        gridVw.setOnItemClickListener { _, _, position, _ ->
            val photo = photos[position]
            startActivity(Intent(this, DetailsActivity::class.java).apply {
                putExtra("photo", photo)
            })
        }

        val photoGridAdapter = PhotoGridAdapter(this, photos)
        gridVw.adapter = photoGridAdapter
    }
}