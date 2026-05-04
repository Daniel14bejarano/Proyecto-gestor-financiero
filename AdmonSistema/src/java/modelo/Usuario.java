package modelo;

public class Usuario {

    private int idUsuario;
    private String nombre;
    private String apellido;
    private int idPerfil;
    private String username;
    private String passwordHash;
    private String fechaCreacion;
    private String estado;

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int v) {
        this.idUsuario = v;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String v) {
        this.nombre = v;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String v) {
        this.apellido = v;
    }

    public int getIdPerfil() {
        return idPerfil;
    }

    public void setIdPerfil(int v) {
        this.idPerfil = v;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String v) {
        this.username = v;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String v) {
        this.passwordHash = v;
    }

    public String getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(String v) {
        this.fechaCreacion = v;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String v) {
        this.estado = v;
    }
}
