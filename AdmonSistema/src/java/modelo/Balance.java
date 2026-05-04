package modelo;

public class Balance {

    private int idBalance;
    private int idUsuario;
    private double totalIngresos;
    private double totalGastos;
    private double balanceActual;

    public int getIdBalance() {
        return idBalance;
    }

    public void setIdBalance(int v) {
        this.idBalance = v;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int v) {
        this.idUsuario = v;
    }

    public double getTotalIngresos() {
        return totalIngresos;
    }

    public void setTotalIngresos(double v) {
        this.totalIngresos = v;
    }

    public double getTotalGastos() {
        return totalGastos;
    }

    public void setTotalGastos(double v) {
        this.totalGastos = v;
    }

    public double getBalanceActual() {
        return balanceActual;
    }

    public void setBalanceActual(double v) {
        this.balanceActual = v;
    }
}
