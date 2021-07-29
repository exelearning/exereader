package com.example.exereader;

import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.google.android.material.navigation.NavigationView;

import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

public class MainActivity extends AppCompatActivity{
    private AppBarConfiguration mAppBarConfiguration;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);

        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_gallery, R.id.nav_slideshow,R.id.nav_ayuda,R.id.nav_sugerencias,R.id.nav_creditos)
                .setDrawerLayout(drawer)
                .build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);

        /* Comprobamos si se está abriendo un proyecto desde fuera de la aplicación */
        Uri uri = getIntent().getData();
        if (uri != null) {
            ClaseSharedPreferences.guardarDatos(this,"uriDefault",String.valueOf(uri));
        }else{
            ClaseSharedPreferences.guardarDatos(this,"uriDefault"," ");
        }

    }

    @Override
    public void onConfigurationChanged(Configuration myConfig) {
        super.onConfigurationChanged(myConfig);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        navigationView = findViewById(R.id.nav_view);
        return true;
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        activarMenu();
        return true;
    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }

    /* Método para controlar el estado de los item del menú */
    public void activarMenu(){
        if(navigationView != null){
            Menu menuNav=navigationView.getMenu();
            MenuItem info = menuNav.findItem(R.id.nav_gallery);
            MenuItem opc = menuNav.findItem(R.id.nav_slideshow);
            info.setEnabled(false);
            opc.setEnabled(false);

            String dire = ClaseSharedPreferences.verDatos(this, "cambio");
            if(dire.equalsIgnoreCase("si")){
                info.setEnabled(true);
                opc.setEnabled(true);
            }
        }
    }
}