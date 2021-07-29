package com.example.exereader;
import android.content.Context;

/**
 * Clase SharedPreferences
 * Es usada para guardar pequeños datos que necesitamos para
 * el correcto funcionamiento de la aplicación.
 * */

public class ClaseSharedPreferences {
    /*Método para obtener las preferencias creadas*/
    public static android.content.SharedPreferences preferencias(Context context){
        return context.getSharedPreferences("info",Context.MODE_PRIVATE);
    }
    /*Método para guardar un dato*/
    public static void guardarDatos(Context context, String key, String value){
        android.content.SharedPreferences.Editor editor= preferencias(context).edit();
        editor.putString(key,value);
        editor.commit();
    }
    /*Método para ver el valor de un dato*/
    public static String verDatos(Context context, String key){
        return preferencias(context).getString(key," ");
    }
    /*Método para eliminar un dato*/
    public static void eliminarDatos(Context context, String key){
        android.content.SharedPreferences.Editor editor= preferencias(context).edit();
        editor.remove(key);
        editor.commit();
    }
}