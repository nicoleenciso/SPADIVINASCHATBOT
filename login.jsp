<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
    <title>Entrada Divina ✨ | DIVINAS SPA</title>
    <style>
        body { 
            background: #ffe4e1; 
            font-family: 'Comic Sans MS', cursive; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0;
        }
        .login-card { 
            background: white; 
            padding: 40px; 
            border-radius: 40px; 
            border: 4px dashed #ff69b4; 
            text-align: center;
            box-shadow: 0 10px 25px rgba(255, 105, 180, 0.3);
            width: 320px;
        }
        h2 { color: #ff1493; margin-bottom: 20px; }
        input { 
            width: 100%; 
            padding: 12px; 
            margin: 10px 0; 
            border-radius: 20px; 
            border: 2px solid #ffb6c1; 
            box-sizing: border-box;
            outline: none;
        }
        input:focus { border-color: #ff69b4; box-shadow: 0 0 8px #ffc0cb; }
        .btn-pink { 
            background: #ff69b4; 
            color: white; 
            border: none; 
            width: 100%; 
            padding: 12px; 
            border-radius: 20px; 
            cursor: pointer; 
            font-weight: bold; 
            font-size: 1.1em;
            transition: 0.3s;
        }
        .btn-pink:hover { background: #ff1493; transform: scale(1.05); }
        .footer-link { color: #db7093; font-size: 0.9em; text-decoration: none; margin-top: 15px; display: block; }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Bienvenida 🎀</h2>
    
    <%
        String userParam = request.getParameter("user");
        String passParam = request.getParameter("pass");

        if (userParam != null && passParam != null) {
            Connection cn = null;
            try {
                Context initContext = new InitialContext();
                DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/myDatasource");
                cn = ds.getConnection();
                
                String sql = "SELECT rol FROM usuarios WHERE username=? AND password=?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, userParam);
                st.setString(2, passParam);
                ResultSet rs = st.executeQuery();
                
                if (rs.next()) {
                    session.setAttribute("username", userParam);
                    session.setAttribute("rol", rs.getString("rol"));
                    
                    response.sendRedirect("divinas_panel.jsp");
                } else {
                    out.print("<p style='color:red; font-weight:bold;'>❌ Usuario o clave incorrectos</p>");
                }
            } catch (Exception e) {
                out.print("<p style='color:orange;'>Error de conexión: " + e.getMessage() + "</p>");
            } finally {
                if (cn != null) cn.close();
            }
        }
    %>

    <form method="POST">
        <input type="text" name="user" placeholder="Tu usuario ✨" required>
        <input type="password" name="pass" placeholder="Tu contraseña 🔑" required>
        <button type="submit" class="btn-pink">Entrar con Estilo 💖</button>
    </form>
    
    <a href="registro.jsp" class="footer-link">¿Aún no eres una Divina? Regístrate aquí 🌸</a>
</div>

</body>
</html>
