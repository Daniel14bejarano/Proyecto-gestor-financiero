package modelo;

public class Categoria {

    private int idCategoria;
    private String nombre;
    private String tipo;
    private String descripcion;

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int v) {
        this.idCategoria = v;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String v) {
        this.nombre = v;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String v) {
        this.tipo = v;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String v) {
        this.descripcion = v;
    }
}
