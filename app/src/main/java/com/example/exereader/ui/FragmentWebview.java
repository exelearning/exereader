package com.example.exereader.ui;

import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.os.Bundle;

import androidx.activity.OnBackPressedCallback;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.navigation.NavController;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

import com.example.exereader.R;
import com.example.exereader.ui.home.HomeFragment;
import com.google.android.material.navigation.NavigationView;

import java.io.File;

/** Clase que abre permite que se muestre el index del proyecto por pantalla
 * pulsando la lista de archivos recientes */

public class FragmentWebview extends Fragment {
    private WebView webview;
    private File paginaWeb;

    /* Constructores */
    public FragmentWebview() {
    }

    public FragmentWebview(File file) {
        this.paginaWeb = file;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_webview, container, false);

        //Ocultamos ActionBar para que el index se muestre a pantalla completa.
        //((AppCompatActivity) getActivity()).getSupportActionBar().hide()

        webview = view.findViewById(R.id.webViewHome);
        if (paginaWeb != null) {
            webview.getSettings().setJavaScriptEnabled(true);
            webview.getSettings().setDomStorageEnabled(true);
            webview.getSettings().setLoadWithOverviewMode(true);
            webview.getSettings().setUseWideViewPort(false);
            webview.getSettings().setSupportZoom(true);
            webview.getSettings().setDefaultTextEncodingName("utf-8");
            webview.getSettings().setAllowContentAccess(true);
            webview.getSettings().setAllowFileAccess(true);
            webview.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
            webview.setWebViewClient(new WebViewClient());

            webview.loadUrl(paginaWeb.getAbsolutePath());
        }

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
}