package com.example.exereader.ui;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;

import androidx.activity.OnBackPressedCallback;
import androidx.annotation.RequiresApi;
import androidx.core.content.FileProvider;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.example.exereader.BuildConfig;
import com.example.exereader.R;
import com.example.exereader.ui.home.HomeFragment;

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
            webview.getSettings().setSupportMultipleWindows(true);
            webview.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
            webview.setWebViewClient(new WebViewClient(){
                /******************** EducaMadrid *******************/
                @SuppressWarnings("deprecation")
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, String url) {
                    String[] parts = url.split("\\?");
                    if (!parts[0].contains("#")) {
                        if(!parts[0].startsWith("https") && !parts[0].startsWith("http") && !parts[0].endsWith(".html") && !parts[0].endsWith(".htm")) {
                            WebView.HitTestResult result = view.getHitTestResult();
                            String data = result.getExtra();
                            Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(data));
                            browserIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                            view.getContext().startActivity(browserIntent);
                        }
                    }

                    return false;
                }

                @RequiresApi(Build.VERSION_CODES.N)
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    String url = request.getUrl().toString();
                    Uri u = request.getUrl();

                    String[] parts = url.split("\\?");

                    if (!parts[0].contains("#")) {
                        if(!parts[0].startsWith("https") && !parts[0].startsWith("http") &&!parts[0].endsWith(".html") && !parts[0].endsWith(".htm")) {
                            Intent i = new Intent(Intent.ACTION_VIEW, FileProvider.getUriForFile(view.getContext(),
                                    "com.example.exereader.fileprovider", new File(u.getPath())));

                            i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                            startActivity(i);
                        }
                    }
                    return false;
                }
            });

            webview.setWebChromeClient(new WebChromeClient() {
                @Override
                public boolean onCreateWindow(WebView view, boolean dialog, boolean userGesture, android.os.Message resultMsg)
                {
                    WebView.HitTestResult result = view.getHitTestResult();
                    String data = result.getExtra();
                    Uri uri = Uri.parse(data);
                    if (data.startsWith("file")) {
                        Intent i = new Intent(Intent.ACTION_VIEW, FileProvider.getUriForFile(view.getContext(),
                                "com.example.exereader.fileprovider", new File(uri.getPath())));

                        i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                        startActivity(i);
                    } else {
                        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(data));
                        view.getContext().startActivity(browserIntent);
                    }
                    return false;
                }
            });
            /******************** EducaMadrid *******************/
            webview.loadUrl(paginaWeb.getAbsolutePath());
        }
        OnBackPressedCallback callback = new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                /* ******* educamadrid ********/
                if (webview.canGoBack()) {
                    webview.goBack();
                    /* ******* educamadrid ********/
                } else {
                    FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                    HomeFragment homeFragment = HomeFragment.newInstance("", "");
                    fragmentTransaction.replace(R.id.nav_host_fragment, homeFragment);
                    fragmentTransaction.commit();
                }
            }
        };
        requireActivity().getOnBackPressedDispatcher().addCallback(getViewLifecycleOwner(), callback);
        return view;
    }
}