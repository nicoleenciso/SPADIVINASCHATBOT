<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Únete a DIVINAS 🌸</title>
    <style>
        body { background: #fff0f5; font-family: cursive; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .card { background: white; padding: 40px; border-radius: 40px; border: 4px solid #ffb6c1; text-align: center; }
        input { width: 80%; padding: 10px; margin: 10px; border-radius: 15px; border: 1px solid #ffb6c1; }
        .btn { background: #ff69b4; color: white; padding: 10px 20px; border: none; border-radius: 20px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Únete a Divinas 🎀</h1>
        <form action="procesar_registro.jsp" method="POST">
            <input type="text" name="user" placeholder="Nombre de Usuario" required><br>
            <input type="password" name="pass" placeholder="Contraseña" required><br>
            <input type="text" name="nombre" placeholder="Tu Nombre Real" required><br>
            <button type="submit" class="btn">¡Crear mi Cuenta Mágica! ✨</button>
        </form>
    </div>
</body>
</html>
