package com.whackylabs.photoapp

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.bumptech.glide.Glide

class PhotoGridAdapter(
    private val context: Context,
    private val photos: List<Photo>,
) :
    BaseAdapter() {

    override fun getCount(): Int {
        return photos.size
    }

    override fun getItem(position: Int): Any {
        return photos[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val contentVw =
            convertView ?: LayoutInflater.from(context).inflate(R.layout.grid_item, parent, false)
        val imageVw: ImageView = contentVw.findViewById(R.id.imageVw)
        val textVw: TextView = contentVw.findViewById(R.id.textVw)

        val photo = photos[position]
        Glide
            .with(context)
            .load(photo.thumbnailUrl)
            .into(imageVw)
        textVw.text = photo.title ?: "-"

        return contentVw
    }
}