package com.whackylabs.demo.photoapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.whackylabs.photoapp.Photoapp;

public class MainActivity extends AppCompatActivity {

    private Photoapp photoapp;

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("photoapplib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        photoapp = Photoapp.create();

        // Example of a call to a native method
        TextView tv = (TextView) findViewById(R.id.sample_text);
        tv.setText(photoapp.getPhotoapp());
    }
}
