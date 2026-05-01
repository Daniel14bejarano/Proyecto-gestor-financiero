<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Bienvenido</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 40px;
    }
    .welcome {
      text-align: center;
    }
    .welcome .icon { font-size: 3rem; margin-bottom: 16px; display: block; }
    .welcome h2 { font-size: 1.5rem; margin-bottom: 8px; }
    .welcome p { color: var(--muted); font-size: 0.95rem; }
  </style>
</head>
<body>
  <div class="welcome">
    <span class="icon">👋</span>
    <h2>Bienvenido al <span style="color:var(--accent)">Sistema</span></h2>
    <p>Selecciona una opción del menú para comenzar.</p>
  </div>
</body>
</html>
