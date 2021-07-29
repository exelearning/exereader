package com.example.exereader.ui;

import android.Manifest;
import android.app.AlertDialog;
import android.content.pm.PackageManager;
import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.exereader.R;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import static androidx.core.content.PermissionChecker.checkSelfPermission;

/** Clase ListaVacia - Se ejecutara en caso de que la aplicación no tenga contenido*/
public class FragmentListaVacia extends Fragment {
    private FloatingActionButton floatingActionButton;
    private static final int REQUEST_PERMISSION_CODE = 5656;

    /* Constructor*/
    public FragmentListaVacia() {
    }

    public static FragmentListaVacia newInstance(String param1, String param2) {
        FragmentListaVacia fragment = new FragmentListaVacia();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_lista_vacia, container, false);
        floatingActionButton = view.findViewById(R.id.btnProyecto);
        floatingActionButton.setOnClickListener(v -> verificarPermisos());
        /*Si no tenemos contenido, la lista está vacía, los item del menú deben estar bloqueados*/
        setHasOptionsMenu(true);

        return view;
    }

    /**  Comprobamos si tenemos permisos para poder abrir el filechooser */
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode,permissions,grantResults);

        if (requestCode == REQUEST_PERMISSION_CODE) {//Este caso se ejecutaría si el usuario cancela los permisos
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                //Si tenemos permisos pasamos a lanzar el selector de archivos (fileChooser)
                FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                FileChooser fileChooser = FileChooser.newInstance(null, "");
                fragmentTransaction.replace(R.id.nav_host_fragment, fileChooser);
                fragmentTransaction.commit();
            } else {
                AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                builder.setMessage("Para poder descomprimir un archivo debe aceptar los permisos.").setTitle("Error")
                        .setPositiveButton("Ok", (dialogInterface, which) -> dialogInterface.cancel());
                builder.show();
            }
        }
    }

    /**
     * Método que verfica los permisos de escritura y lectura para poder
     * seleccionar el archivo.
     * Se ejecuta la primera vez que instalamos la aplicación.
     */
    private void verificarPermisos() {
        //Obtenemos los permisos de escritura.
        int permission = checkSelfPermission(getContext(), Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (permission != PackageManager.PERMISSION_GRANTED) {
            //SI no tenemos permisos los solicita por pantalla al usuario.
            requestPermissions(new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE,Manifest.permission.INTERNET},
                    REQUEST_PERMISSION_CODE);
        }else{
            FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            FileChooser fileChooser = FileChooser.newInstance("","");

            fragmentTransaction.replace(R.id.nav_host_fragment, fileChooser);
            fragmentTransaction.commit();
        }
    }
}