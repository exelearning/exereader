package com.example.exereader.ui.ayuda;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.fragment.app.Fragment;

import com.example.exereader.R;

import java.util.Locale;

/** Ayuda */
public class AyudaFragment extends Fragment {
    private WebView web;
    private String idioma;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_creditos, container, false);
        web = view.findViewById(R.id.web);
        web.setWebViewClient(new WebViewClient());

        idioma =  Locale.getDefault().getLanguage(); // es
        if(!idioma.equalsIgnoreCase("es")){
            web.loadUrl("file:///android_asset/ayuda_en.html");
        }else{
            web.loadUrl("file:///android_asset/ayuda.html");
        }
        return view;
    }
}