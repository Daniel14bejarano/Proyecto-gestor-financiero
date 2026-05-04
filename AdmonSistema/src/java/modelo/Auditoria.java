package modelo;

public class Auditoria {
    private int    idAuditoria;
    private int    idTransaccion;
    private String accion;
    private String fecha;
    private String descripcion;

    public int    getIdAuditoria()          { return idAuditoria; }
    public void   setIdAuditoria(int v)     { this.idAuditoria = v; }
    public int    getIdTransaccion()        { return idTransaccion; }
    public void   setIdTransaccion(int v)   { this.idTransaccion = v; }
    public String getAccion()               { return accion; }
    public void   setAccion(String v)       { this.accion = v; }
    public String getFecha()                { return fecha; }
    public void   setFecha(String v)        { this.fecha = v; }
    public String getDescripcion()          { return descripcion; }
    public void   setDescripcion(String v)  { this.descripcion = v; }
}
