package com.example.exereader.ui;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;

import androidx.activity.OnBackPressedCallback;
import androidx.annotation.Nullable;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import android.provider.OpenableColumns;

import com.example.exereader.ClaseSharedPreferences;
import com.example.exereader.MainActivity;
import com.example.exereader.R;
import com.example.exereader.ui.home.HomeFragment;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

public class FileChooser extends Fragment {
    private WebView webView;
    private String titulo="";
    String idioma =  Locale.getDefault().getLanguage(); // es


    public static FileChooser newInstance(String uri, String param2) {
        FileChooser fragment = new FileChooser();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_home_archivo, container, false);

        webView = view.findViewById(R.id.wView);

        //Controlamos desde donde estamos accediendo a la aplicación
        Uri uriDefault = Uri.parse(ClaseSharedPreferences.verDatos(getContext(), "uriDefault"));
        if (!ClaseSharedPreferences.verDatos(getContext(), "uriDefault").equals(" ")) {
            cargarZipProyecto(uriDefault);
        } else {
            selectorDeArchivos();
        }

        //Botón back del dispositivo
        OnBackPressedCallback callback = new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                HomeFragment homeFragment = HomeFragment.newInstance("", "");
                fragmentTransaction.replace(R.id.nav_host_fragment, homeFragment);
                fragmentTransaction.commit();
            }
        };
        requireActivity().getOnBackPressedDispatcher().addCallback(getViewLifecycleOwner(), callback);

        return view;
    }

    /**
     * Método que lanza el selector de archivos, permite navegar por las carpertas del dispositivo
     * para buscar el archivo a descomprimir.
     */
    private void selectorDeArchivos() {
        //Creamos un intent de tipo selector de archivos
        Intent selector = new Intent(Intent.ACTION_GET_CONTENT);
        selector.setType("application/zip");
        selector.addCategory(Intent.CATEGORY_OPENABLE);
        if(!idioma.equalsIgnoreCase("es")) {
            selector = Intent.createChooser(selector, "Select a file");
        }else{
            selector = Intent.createChooser(selector, "Seleccione un archivo");
        }
        //Utilizamos el método que lanza el intent, el cual espera una seleccion del usuario,
        //para poder trabajar con él en el método de Android - onActivityResult
        startActivityForResult(selector, 2000);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 2000) {
            if (resultCode == Activity.RESULT_OK) {
                //Si el usuario ha seleccionado correctamente un archivo.
                cargarZipProyecto(data.getData());
            } else {
                FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                HomeFragment h = HomeFragment.newInstance("", "");
                fragmentTransaction.replace(R.id.nav_host_fragment, h);
                fragmentTransaction.commit();
            }
        }
    }

    /**
     * Método que carga el proyecto seleccionado y
     * guarda los datos necesarios para poder trabajar con el archivo.
     */
    private void cargarZipProyecto(Uri uri) {
        String nombreArchivo = "";
        ClaseSharedPreferences.guardarDatos(getContext(), "Uri", String.valueOf(uri));

        String mime = getContext().getContentResolver().getType(uri);
        if (mime != null) {
            Cursor cursor = getContext().getContentResolver().query(uri, null, null, null, null);
            int nIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);
            cursor.moveToFirst();
            nombreArchivo = cursor.getString(nIndex);

            String path = getContext().getExternalFilesDir(null).toString();
            File archivoComprimido = new File(path + "/" + nombreArchivo);

            if (archivoComprimido.getAbsolutePath().contains(".zip")) {
                String carpetaProyecto = archivoComprimido.getAbsolutePath().substring(0, archivoComprimido.getAbsolutePath().length() - 4);
                ClaseSharedPreferences.guardarDatos(getContext(), "archivo", carpetaProyecto);
            } else {
                ClaseSharedPreferences.guardarDatos(getContext(), "archivo", archivoComprimido.getAbsolutePath());
            }
            copiarArchivo(archivoComprimido, uri, getContext());
            descomprimir(archivoComprimido);
        }
    }

    /**
     * Método que descomprime un archivo. Si salta alguna excepción cambia de fragment
     * mostrando el error en un dialogo.
     */
    private void descomprimir(File zip) {
        File f = null;
        try {
            //Carpeta donde descomprime
            File carpetaDescomprimir = new File(zip.getParent() + "/" + zip.getName().replace(".zip", ""));
            if (!carpetaDescomprimir.exists()) {
                carpetaDescomprimir.mkdirs();
            } else {
                borrarDirectorio(carpetaDescomprimir);
            }
            ZipInputStream zipFlujo = new ZipInputStream(new FileInputStream(zip));
            ZipEntry zipEntry;
            byte[] buffer = new byte[1024];
            int count;
            while ((zipEntry = zipFlujo.getNextEntry()) != null) {
                if (zipEntry.isDirectory()) {
                    f = new File(carpetaDescomprimir.getAbsolutePath() + zipEntry.getName());
                    if (!f.isDirectory()) {
                        f.mkdirs();
                    }
                } else {
                    File file = new File(carpetaDescomprimir, zipEntry.getName());
                    FileOutputStream fileOutputStream = new FileOutputStream(file);
                    while ((count = zipFlujo.read(buffer)) != -1) {
                        fileOutputStream.write(buffer, 0, count);
                    }
                    //Cerramos los flujos
                    zipFlujo.closeEntry();
                    fileOutputStream.close();
                }
            }
            zipFlujo.close();
            //Cargamos el index
            verHtml(carpetaDescomprimir);
        } catch (Exception e) {
            e.printStackTrace();
            AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
            if(!idioma.equalsIgnoreCase("es")){
                builder.setMessage("File incompatible with eXeReader.").setTitle("Error")
                        .setPositiveButton("Ok", (dialogInterface, which) -> dialogInterface.cancel());
            }else {
                builder.setMessage("Archivo incompatible con eXeReader.").setTitle("Error")
                        .setPositiveButton("Ok", (dialogInterface, which) -> dialogInterface.cancel());
            }
            builder.show();
            FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            HomeFragment h = HomeFragment.newInstance("", "");
            fragmentTransaction.replace(R.id.nav_host_fragment, h);
            fragmentTransaction.commit();
        }
    }

    /**
     * Método para borrar el contenido de un directorio
     */
    private void borrarDirectorio(File f) {
        File[] archivos = f.listFiles();
        for (int i = 0; i < archivos.length; i++) {
            if (archivos[i].isDirectory()) {
                borrarDirectorio(archivos[i]);
            } else {
                archivos[i].delete();
            }
        }
    }


    /**
     * Método que hace una copia de un archivo por su uri para poder obtener el fichero,
     * es necesario ya que el Selector de Archivos (FileChooser) solo nos devuelve una uri.
     */
    private void copiarArchivo(File dest, Uri uri, Context context) {
        InputStream is = null;
        OutputStream os = null;
        try {
            is = context.getContentResolver().openInputStream(uri);
            os = new FileOutputStream(dest);
            byte[] buffer = new byte[1024];
            int length;

            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Método que busca el index.html y lo carga en el webView, activando los ajustes
     * necesarios para su correcto funcionamiento.
     * Guarda datos para poder trabajar con el proyecto en otras ventanas.
     */
    private void verHtml(File directorio) {
        ClaseSharedPreferences.guardarDatos(getContext(), "directorio", directorio.getAbsolutePath());

        File[] archivos = directorio.listFiles();
        File index = null;

        for (int i = 0; i < archivos.length; i++) {
            if (archivos[i].getName().equals("index.html")) {
                index = archivos[i];
            }

            if (archivos[i].getName().equals("contentv3.xml")) {
                leerArchivo(archivos[i]);
            }
        }

        //Si el archivo contiene un index.html activamos JavaScript, los accesos por url y cargamos el contenido en el webview
        if (index != null) {
            //Activamos las opciones de SobreProyecto del menú
            ClaseSharedPreferences.guardarDatos(getContext(), "cambio", "si");
            ((MainActivity) getActivity()).activarMenu();
            webView.getSettings().setJavaScriptEnabled(true);
            webView.getSettings().setDomStorageEnabled(true);
            webView.getSettings().setLoadWithOverviewMode(true);
            webView.getSettings().setUseWideViewPort(false);
            webView.getSettings().setSupportZoom(true);
            webView.getSettings().setDefaultTextEncodingName("utf-8");
            webView.getSettings().setAllowContentAccess(true);
            webView.getSettings().setAllowFileAccess(true);
            webView.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
            webView.setWebViewClient(new WebViewClient());
            webView.loadUrl(index.getAbsolutePath());

        }
        ClaseSharedPreferences.eliminarDatos(getContext(), "uriDefault");
    }

    /**
     * Método para leer los archivos de configuración y así poder mostrar el título
     * y el nombre del autor en la lista de archivos recientes
     */
    public void leerArchivo(File xmlDatos) {
        try {
            DocumentBuilderFactory db = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentB = db.newDocumentBuilder();
            Document doc = documentB.parse(new File(xmlDatos.getAbsolutePath()));

            NodeList nList = doc.getElementsByTagName("dictionary");
            for (int j = 0; j < nList.getLength(); j++) {
                NodeList nListString = nList.item(j).getChildNodes();
                if (nListString.getLength() > 0) {
                    for (int i = 0; i < nListString.getLength(); i++) {
                        Node nNode = nListString.item(i);

                        if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                            Element eElement = (Element) nNode;

                            if (eElement.getAttribute("value").equals("_title") && titulo.equals("")) {
                                Node nodoSiguiente = nListString.item(i + 2);
                                Element eElementSiguiente = (Element) nodoSiguiente;
                                titulo = eElementSiguiente.getAttribute("value");
                                ClaseSharedPreferences.guardarDatos(getContext(), "tp", titulo);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}