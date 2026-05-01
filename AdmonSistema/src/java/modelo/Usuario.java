package modelo;

public class Usuario {

    private int iddato;
    private String identificacion;
    private String nombre;
    private String apellido;
    private String email;
    private String telefono;
    private String usuario;
    private String clave;
    private String perfil;

    public Usuario() {
    }

    public int getIddato() {
        return iddato;
    }

    public void setIddato(int v) {
        this.iddato = v;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String v) {
        this.identificacion = v;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String v) {
        this.email = v;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String v) {
        this.telefono = v;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String v) {
        this.usuario = v;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String v) {
        this.clave = v;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String v) {
        this.perfil = v;
    }
}
