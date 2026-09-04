<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="spaBean" class="com.divinas.beans.SpaBean" scope="session" />
<%
    String u = request.getParameter("user");
    String p = request.getParameter("pass");
    String n = request.getParameter("nombre");

    if (u != null && p != null && n != null) {

    if (spaBean.registrarUsuario(u, p, n, "clienta")) {
            session.setAttribute("username", u);
            session.setAttribute("rol", "clienta");
            response.sendRedirect("divinas_panel.jsp");
        } else {
            out.print("<script>alert('Error: El nombre de usuario ya existe. Intenta con otro ✨'); window.location='registro.jsp';</script>");
        }
    } else {
        response.sendRedirect("registro.jsp");
    }
%>
