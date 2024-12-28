package com.whackylabs.photoapp

import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.bumptech.glide.Glide

class DetailsActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_details)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val photo = intent.getSerializableExtra("photo") as Photo

        val imageVw: ImageView = findViewById(R.id.imageVw)
        val textVw: TextView = findViewById(R.id.textVw)

        Glide
            .with(this)
            .load(photo.url)
            .thumbnail(
                Glide.with(this).load(photo.thumbnailUrl)
            )
            .into(imageVw)
        textVw.text = photo.title ?: "-"
    }
}