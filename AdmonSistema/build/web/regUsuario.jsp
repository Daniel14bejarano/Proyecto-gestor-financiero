<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro de Usuario</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div class="card">
            <h2>Registro de <span>Usuario</span></h2>
            <form id="form1" name="form1" method="post" action="controladorUsuario">
                <div class="form-group">
                    <label for="cid">Identificación</label>
                    <input type="text" name="cid" id="cid" required>
                </div>
                <div class="form-group">
                    <label for="cnombre">Nombres</label>
                    <input type="text" name="cnombre" id="cnombre" required>
                </div>
                <div class="form-group">
                    <label for="capellido">Apellidos</label>
                    <input type="text" name="capellido" id="capellido" required>
                </div>
                <div class="form-group">
                    <label for="cmail">E-mail</label>
                    <input type="email" name="cmail" id="cmail">
                </div>
                <div class="form-group">
                    <label for="ctelefono">Teléfono</label>
                    <input type="text" name="ctelefono" id="ctelefono">
                </div>
                <div class="form-group">
                    <label for="cusuario">Usuario</label>
                    <input type="text" name="cusuario" id="cusuario" required>
                </div>
                <div class="form-group">
                    <label for="cclave">Clave</label>
                    <input type="password" name="cclave" id="cclave" required>
                </div>

                <%-- Perfil fijo como "user", no visible para el usuario --%>
                <input type="hidden" name="cperfil" value="user">

                <button type="submit" class="btn btn-primary">Registrarse</button>
            </form>
            <div class="actions">
                <a href="login.jsp" class="link">← Volver al login</a>
            </div>
        </div>
    </body>
</html>