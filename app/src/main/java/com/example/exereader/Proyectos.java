package com.example.exereader;

/** Clase con la que referenciamos a los proyectos con los que trabaja
 * la aplicación */
public class Proyectos {
    private String imagen;
    private String titulo,autor;
    private Long fecha;
    private String uri;
    private String nombrecarpeta;

    /* Constructor parametrizado*/
    public Proyectos(String imagen, String titulo, String autor, Long fecha, String uri,String nombrecarpeta) {
        this.imagen = imagen;
        this.titulo = titulo;
        this.autor= autor;
        this.fecha = fecha;
        this.uri = uri;
        this.nombrecarpeta = nombrecarpeta;
    }

    /* Getters y Setters*/
    public String getImagen() { return imagen; }

    public void setImagen(String imagen) { this.imagen = imagen; }

    public String getTitulo() { return titulo; }

    public void setTitulo(String titulo) { this.titulo = titulo; }

    public Long getFecha() { return fecha; }

    public void setFecha(Long fecha) { this.fecha = fecha; }

    public String getUri() { return uri; }

    public void setUri(String uri) { this.uri = uri; }

    public String getAutor() { return autor; }

    public void setAutor(String autor) { this.autor = autor; }

    public String getNombrecarpeta() { return nombrecarpeta; }

    public void setNombrecarpeta(String nombrecarpeta) { this.nombrecarpeta = nombrecarpeta;}
}
