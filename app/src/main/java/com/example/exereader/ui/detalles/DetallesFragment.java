package com.example.exereader.ui.detalles;

import android.app.AlertDialog;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebViewClient;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.example.exereader.ClaseSharedPreferences;
import com.example.exereader.R;
import com.example.exereader.ui.home.HomeFragment;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

/** DETALLES
 *  Esta clase sirve para leer los archivos correspondientes para poder
 *  mostrar la información*/

public class DetallesFragment extends Fragment {
    private TextView t,a,d,idi,l;
    String titulo="",author="",descripcion="",idioma="",licencia="";



    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        View root = inflater.inflate(R.layout.fragment_detalles, container, false);

        t = root.findViewById(R.id.t);
        a = root.findViewById(R.id.a);
        d = root.findViewById(R.id.d);
        idi = root.findViewById(R.id.i);
        l = root.findViewById(R.id.l);

        String idioma =  Locale.getDefault().getLanguage(); // es
        String dire = ClaseSharedPreferences.verDatos(getContext(), "archivo");
        File directorio = new File(dire);

        File[] archivos = directorio.listFiles();
        File xmlDatos;
        File html;
        if(archivos.length > 0){
            for (int i = 0; i < archivos.length; i++) {
                if (archivos[i].getName().equals("index.html")) {
                    html = archivos[i];
                    if(html.exists()){
                        try {
                            leerIndex(html);
                        } catch (IOException ioException) {
                            ioException.printStackTrace();
                        }
                    }else{
                        AlertDialog.Builder builder = new AlertDialog.Builder(getContext());

                        if(!idioma.equalsIgnoreCase("es")){
                            builder.setMessage("The index.html file was not found.").setTitle("Error")
                                    .setPositiveButton("Ok", (dialogInterface, which) -> dialogInterface.cancel());
                        }else {
                            builder.setMessage("No se ha encontrado el archivo index.html.").setTitle("Error")
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
                if (archivos[i].getName().equals("contentv3.xml")) {
                    xmlDatos = archivos[i];
                    if(xmlDatos.exists()){
                        leerArchivo(xmlDatos);
                    }else{
                        AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                        if(!idioma.equalsIgnoreCase("es")){
                            builder.setMessage("Could not find a configuration file to get information from.").setTitle("Error")
                                    .setPositiveButton("Ok", (dialogInterface, which) -> dialogInterface.cancel());
                        }else{
                            builder.setMessage("No se ha encontrado un archivo de configuración del cual obtener información.").setTitle("Error")
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
            }
        }
        return root;
    }

    /** Método para leer el index y obtener información sobre la licencia */
    private void leerIndex(File html) throws IOException {
        String cadena;
        FileReader f = new FileReader(html);
        BufferedReader b = new BufferedReader(f);
        while((cadena = b.readLine())!=null) {
            if(cadena.contains("license")){
                String patron = "href=\".*?\"";
                Pattern pattern = Pattern.compile(patron);
                Matcher matcher = pattern.matcher(cadena);
                if(matcher.find()){
                    int index = matcher.group().indexOf("\"");
                    licencia = matcher.group().substring(index + 1,matcher.group().length() - 1);
                }
            }
        }
        b.close();
        if(!licencia.equals("")){
            l.setText(licencia);
        }else{
            // poner nuevo string
            l.setTextColor(ContextCompat.getColor(this.getContext(), R.color.grisOscuro));
            l.setText(R.string.no_info);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    /** Método para leer un archivo y sacar la información necesaria para mostrarla en el
     * fragment de información */
    public void leerArchivo(File xmlDatos){
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(new File(xmlDatos.getAbsolutePath()));

            NodeList nList = doc.getElementsByTagName("dictionary");
            for (int j = 0; j < nList.getLength(); j++) {
                NodeList nListString = nList.item(j).getChildNodes();
                if (nListString.getLength() > 0){
                    for(int i = 0; i < nListString.getLength(); i++) {
                        Node nNode = nListString.item(i);

                        if(nNode.getNodeType() == Node.ELEMENT_NODE) {
                            Element eElement = (Element) nNode;

                            if (eElement.getAttribute("value").equals("_title") && titulo.equals("")){
                                Node nodoSiguiente = nListString.item(i+2);
                                Element eElementSiguiente = (Element) nodoSiguiente;
                                titulo = eElementSiguiente.getAttribute("value");
                                if (titulo.equals("")) {
                                    titulo = getString(R.string.no_info);
                                    t.setTextColor(ContextCompat.getColor(this.getContext(), R.color.grisOscuro));
                                }
                                t.setText(titulo);
                            }

                            if (eElement.getAttribute("value").equals("_author") && author.equals("")){
                                Node nodoSiguiente = nListString.item(i+2);
                                Element eElementSiguiente = (Element) nodoSiguiente;
                                author = eElementSiguiente.getAttribute("value");
                                if (author.equals("")) {
                                    author = getString(R.string.no_info);
                                    a.setTextColor(ContextCompat.getColor(this.getContext(), R.color.grisOscuro));
                                }
                                a.setText(author);
                            }

                            if (eElement.getAttribute("value").equals("_description") && descripcion.equals("")){
                                Node nodoSiguiente = nListString.item(i+2);
                                Element eElementSiguiente = (Element) nodoSiguiente;
                                descripcion = eElementSiguiente.getAttribute("value");
                                if (descripcion.equals("")) {
                                    // poner nuevo string
                                    descripcion = getString(R.string.no_info);
                                    d.setTextColor(ContextCompat.getColor(this.getContext(), R.color.grisOscuro));
                                }
                                d.setText(descripcion);
                            }

                            if (eElement.getAttribute("value").equals("_lang") && idioma.equals("")){
                                Node nodoSiguiente = nListString.item(i+2);
                                Element eElementSiguiente = (Element) nodoSiguiente;
                                idioma = eElementSiguiente.getAttribute("value");
                                if (idioma.equals("")) {
                                    // poner nuevo string
                                    idioma = getString(R.string.no_info);
                                    idi.setTextColor(ContextCompat.getColor(this.getContext(), R.color.grisOscuro));
                                }
                                idi.setText(idioma);
                            }
                        }
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}