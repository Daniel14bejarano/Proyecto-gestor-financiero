package modelo;

public class Transaccion {

    private int idTransaccion;
    private int idUsuario;
    private int idCategoria;
    private String nombreCategoria;
    private String tipoCategoria;
    private String fecha;
    private String descripcion;
    private double monto;
    private String fechaRegistro;

    public int getIdTransaccion() {
        return idTransaccion;
    }

    public void setIdTransaccion(int v) {
        this.idTransaccion = v;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int v) {
        this.idUsuario = v;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int v) {
        this.idCategoria = v;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String v) {
        this.nombreCategoria = v;
    }

    public String getTipoCategoria() {
        return tipoCategoria;
    }

    public void setTipoCategoria(String v) {
        this.tipoCategoria = v;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String v) {
        this.fecha = v;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String v) {
        this.descripcion = v;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double v) {
        this.monto = v;
    }

    public String getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(String v) {
        this.fechaRegistro = v;
    }
}
