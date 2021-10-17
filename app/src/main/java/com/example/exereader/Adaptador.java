package com.example.exereader;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.OnBackPressedCallback;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.recyclerview.widget.RecyclerView;

import com.example.exereader.ui.FragmentWebview;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;

public class Adaptador extends RecyclerView.Adapter<Adaptador.RecyclerHolder> {
    private final ArrayList<Proyectos> lista;
    private WebView webview;
    private boolean editable;
    private CardView card;
    private final AppCompatActivity actividad;

    /* *********** educamadrid ********** */
    private boolean esModoNoche;
    /* *********** educamadrid ********** */

    /* Constructor parametrizado */
    public Adaptador(ArrayList<Proyectos> lista, AppCompatActivity actividad) {
        this.lista = lista;
        this.actividad = actividad;
    }

    @NonNull
    @Override
    public RecyclerHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_adaptador,parent,false);

        View view2 = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_home_archivo,parent,false);
        webview = view2.findViewById(R.id.wView);
        card = view.findViewById(R.id.cardSeccion);

        esModoNoche = comprobarModoNoche(parent.getContext());

        return new RecyclerHolder(view);
    }

    /** Método para cambiar el orden por fecha del array que simula la lista de archivos recientes */
    public void cambiarOrden(){
        Collections.sort(lista, (p1,p2) -> p2.getFecha().compareTo(p1.getFecha()));
    }

    /* *********** educamadrid ********** */
    /** Método para comprobar qué modo está activado en el dispositivo **/
    public boolean comprobarModoNoche(Context context) {
       boolean esModoNoche = false;

       Configuration configuration = context.getResources().getConfiguration();

        int currentNightMode = configuration.uiMode & Configuration.UI_MODE_NIGHT_MASK;
        switch (currentNightMode) {
            case Configuration.UI_MODE_NIGHT_YES:
                //modo oscuro
                esModoNoche = true;
                break;
        }

       return esModoNoche;
    }
    /* *********** educamadrid ********** */

    @Override
    public void onBindViewHolder(@NonNull RecyclerHolder holder, int position) {
        Proyectos proyectos = lista.get(position);

        //Control de color en los cardView
        if(position % 2 != 0){
            card.setCardBackgroundColor(Color.parseColor("#E6E6E6"));
        }
        /* *********** educamadrid ********** */
        if (esModoNoche) {
            if(position % 2 == 0){
                card.setCardBackgroundColor(Color.WHITE);
            }
        }
        /* *********** educamadrid ********** */

        //Ponemos los datos en la lista
        holder.titulo.setText(proyectos.getTitulo());
        holder.autor.setText(proyectos.getAutor());
        if(proyectos.getImagen() != null){
            FileInputStream in = null;
            try {
                in = new FileInputStream(proyectos.getImagen());
                holder.imagen.setImageBitmap(BitmapFactory.decodeStream(in));
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }else{
            holder.imagen.setImageResource(R.drawable.exelearning);
        }
        holder.itemView.setOnClickListener(v -> {
            int contador = 0;
            String path = v.getContext().getExternalFilesDir(null).toString();
            File carpetaFicheros = new File(path);
            File[] files = carpetaFicheros.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (files[i].isDirectory() && proyectos.getNombrecarpeta().equalsIgnoreCase(files[i].getName())) {
                    files[i].setLastModified(System.currentTimeMillis());
                    ClaseSharedPreferences.guardarDatos(v.getContext(), "archivo", files[i].getAbsolutePath());
                    ClaseSharedPreferences.guardarDatos(v.getContext(), "directorio", files[i].getAbsolutePath());
                    ClaseSharedPreferences.guardarDatos(v.getContext(), "Uri", proyectos.getUri());
                    ClaseSharedPreferences.guardarDatos(v.getContext(), "tp", proyectos.getTitulo());
                    File[] archivos = files[i].listFiles();
                    File index = null;
                    //Hacemos las comprobaciones necesarias para poder trabajar con el proyecto
                    for (int x = 0; x < archivos.length; x++) {
                        if (archivos[i].getName().equals("content.data")) {
                            contador++;
                        }
                        if (archivos[i].getName().equals("contentv3.xml")) {
                            contador++;
                        }
                        if (contador == 2) {
                            editable = true;
                            ClaseSharedPreferences.guardarDatos(v.getContext(), "editable", String.valueOf(editable));
                            contador = 0;
                        }
                        if (archivos[x].getName().equals("index.html")) {
                            index = archivos[x];
                            ClaseSharedPreferences.guardarDatos(v.getContext(), "cambio", "si");
                            //Como hemos encontrado un index para mostrar por pantalla, activamos los item del menú
                            ((MainActivity) v.getContext()).activarMenu();
                            FragmentWebview fragment = new FragmentWebview(index);
                            FragmentManager fragmentManager = actividad.getSupportFragmentManager();
                            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                            fragmentTransaction.replace(R.id.nav_host_fragment, fragment);
                            fragmentTransaction.commit();
                        }
                    }
                }
            }
        });
    }
    /** Método que devuelve el tamaño total de la lista*/
    @Override
    public int getItemCount() {
        return lista.size();
    }

    /** Clase que almacena los datos de los proyectos para mostrarlos en el cardView*/
    public static class RecyclerHolder extends RecyclerView.ViewHolder implements View.OnClickListener{
        private final ImageView imagen;
        private final TextView titulo;
        private final TextView autor;

        public RecyclerHolder(@NonNull View itemView) {
            super(itemView);
            imagen=itemView.findViewById(R.id.imagen);
            titulo=itemView.findViewById(R.id.titulo);
            autor=itemView.findViewById(R.id.autorAdap);
        }

        @Override
        public void onClick(View v) {
            int posicion = getAdapterPosition();
        }
    }


}