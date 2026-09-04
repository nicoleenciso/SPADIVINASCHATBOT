<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="spa" class="com.divinas.beans.SpaBean" scope="session" />
<%
    String rol = (String)session.getAttribute("rol");
    String user = (String)session.getAttribute("username");
    
    if (user == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    if(request.getParameter("acc") != null) {
        String acc = request.getParameter("acc");
        
        if(acc.equals("add")) {
            spa.agendar(user, request.getParameter("s"), request.getParameter("emp"), request.getParameter("h"));
        } else if(acc.equals("est")) {
            spa.setEstado(request.getParameter("id"), request.getParameter("n"));
        } else if(acc.equals("regEmp")) {
            spa.registrarUsuario(request.getParameter("u"), request.getParameter("p"), request.getParameter("n"), "empleada");
        }
        response.sendRedirect("divinas_panel.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de Control | DIVINAS SPA ✨</title>
    <style>
        body { 
            background: #fff0f5; 
            font-family: 'Comic Sans MS', cursive; 
            color: #d14781; 
            margin: 0; 
            padding: 20px; 
        }
        /* Contenedor del Traductor */
        .translate-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 10px;
            gap: 10px;
            font-size: 14px;
            font-weight: bold;
        }
        .header { 
            background: white; 
            padding: 20px; 
            border-radius: 50px; 
            border: 3px dashed #ffb6c1; 
            text-align: center; 
            margin-bottom: 20px;
        }
        .card { 
            background: white; 
            border-radius: 30px; 
            padding: 25px; 
            border: 2px solid #ffb6c1; 
            margin-bottom: 20px; 
            box-shadow: 0 5px 15px #ffc0cb; 
        }
        h1, h2 { color: #ff1493; margin-top: 0; }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            background: white; 
            border-radius: 15px; 
            overflow: hidden; 
        }
        th { background: #ffb6c1; color: white; padding: 12px; }
        td { padding: 10px; border-bottom: 1px solid #ffe4e1; text-align: center; }
        
        /* Botones */
        .btn { 
            padding: 10px 18px; 
            border-radius: 20px; 
            text-decoration: none; 
            border: none; 
            cursor: pointer; 
            color: white; 
            font-weight: bold; 
            display: inline-block;
            transition: 0.3s;
        }
        .pink { background: #ff69b4; } 
        .blue { background: #87cefa; } 
        .green { background: #98fb98; color: #2e8b57; }
        .red { background: #ff8a80; }
        .btn:hover { opacity: 0.8; transform: scale(1.05); }

        /* Formulario */
        input, select { 
            padding: 12px; 
            border-radius: 15px; 
            border: 1px solid #ffb6c1; 
            margin: 10px 5px; 
            width: 280px;
        }
        optgroup {
            font-weight: bold;
            color: #ff1493;
            background-color: #fff0f5;
        }
        option {
            color: #d14781;
            background-color: #ffffff;
            padding: 5px;
        }
        label { font-weight: bold; display: block; margin-left: 10px; }

        /* Chatbot Clienta */
        .chat-btn-float {
            position: fixed;
            bottom: 25px;
            right: 25px;
            background: #ff1493;
            color: white;
            border: 2px solid white;
            border-radius: 50px;
            padding: 14px 22px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(255, 20, 147, 0.4);
            transition: 0.3s;
            z-index: 1000;
        }
        .chat-btn-float:hover { transform: scale(1.1); }

        .chat-container {
            display: none;
            position: fixed;
            bottom: 85px;
            right: 25px;
            width: 330px;
            height: 430px;
            background: white;
            border-radius: 25px;
            border: 3px solid #ffb6c1;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            flex-direction: column;
            overflow: hidden;
            z-index: 1000;
        }
        .chat-header {
            background: #ff69b4;
            color: white;
            padding: 12px 18px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .chat-body {
            flex: 1;
            padding: 12px;
            overflow-y: auto;
            background: #fff0f5;
            display: flex;
            flex-direction: column;
            gap: 10px;
            font-size: 14px;
        }
        .chat-msg {
            padding: 8px 12px;
            border-radius: 15px;
            max-width: 80%;
            word-wrap: break-word;
        }
        .msg-bot { background: white; color: #d14781; align-self: flex-start; border: 1px solid #ffb6c1; }
        .msg-user { background: #ff1493; color: white; align-self: flex-end; }
        
        .chat-footer {
            display: flex;
            padding: 8px;
            background: white;
            border-top: 1px solid #ffe4e1;
        }
        .chat-footer input {
            flex: 1;
            width: 100%;
            margin: 0;
            padding: 8px 12px;
            border-radius: 12px;
        }
        .chat-footer button {
            margin-left: 5px;
            padding: 8px 12px;
            border-radius: 12px;
        }
    </style>
</head>
<body>

    <!-- BARRA DE TRADUCCIÓN GLOBAL (CLIENTAS, EMPLEADAS Y GERENTE) -->
    <div class="translate-bar">
        <span>🌐 Idioma / Language:</span>
        <div id="google_translate_element"></div>
    </div>

    <div class="header">
        <h1>🌸 DIVINAS SPA ✨</h1>
        <p>Bienvenida, <b><%= user %></b> (<%= rol.toUpperCase() %>) | <a href="logout.jsp" style="color: #ff69b4; font-weight: bold;">Cerrar Sesión 🎀</a></p>
    </div>

    <% if("gerente".equals(rol)) { %>
        <div class="card">
            <h2>👩‍💼 Registro de Personal</h2>
            <form method="POST">
                <input type="hidden" name="acc" value="regEmp">
                <input name="u" placeholder="Usuario nuevo" required>
                <input name="p" type="password" placeholder="Contraseña" required>
                <input name="n" placeholder="Nombre de la empleada" required>
                <button type="submit" class="btn pink">Registrar personal de divinas ✨</button>
            </form>
        </div>
    <% } %>

    <% if("clienta".equals(rol)) { %>
        <div class="card">
            <h2>💅 Mi Cita de Belleza</h2>
            <form method="POST">
                <input type="hidden" name="acc" value="add">
                
                <div style="display: flex; flex-wrap: wrap; gap: 10px;">
                    <div>
                        <label>Servicio:</label>
                        <select name="s" required style="width: 300px;">
                            <option value="" disabled selected>-- Elige un Servicio --</option>
                            
                            <optgroup label="👁️ Pestañas y Cejas">
                                <c:forEach var="serv" items="${spa.listaServicios}">
                                    <c:if test="${serv.value.contains('Pestañas') || serv.value.contains('Cejas') || serv.value.contains('Lifting') || serv.value.contains('Microblading') || serv.value.contains('Laminado')}">
                                        <option value="${serv.key}">${serv.value}</option>
                                    </c:if>
                                </c:forEach>
                            </optgroup>

                            <optgroup label="💅 Uñas y Manicura">
                                <c:forEach var="serv" items="${spa.listaServicios}">
                                    <c:if test="${serv.value.contains('Uñas') || serv.value.contains('Manicura') || serv.value.contains('Kapping') || serv.value.contains('Poligel') || serv.value.contains('Acrílic')}">
                                        <option value="${serv.key}">${serv.value}</option>
                                    </c:if>
                                </c:forEach>
                            </optgroup>

                            <optgroup label="💆‍♀️ Masajes y Faciales">
                                <c:forEach var="serv" items="${spa.listaServicios}">
                                    <c:if test="${serv.value.contains('Masaje') || serv.value.contains('Facial') || serv.value.contains('Limpieza') || serv.value.contains('Velas') || serv.value.contains('Oro')}">
                                        <option value="${serv.key}">${serv.value}</option>
                                    </c:if>
                                </c:forEach>
                            </optgroup>
                        </select>
                    </div>

                    <div>
                        <label>Especialista:</label>
                        <select name="emp" required style="width: 250px;">
                            <c:forEach var="e" items="${spa.listaEmpleadas}">
                                <option value="${e.key}">${e.value}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label>Hora:</label>
                        <input type="time" name="h" required style="width: 150px;">
                    </div>
                </div>
                
                <button type="submit" class="btn pink" style="margin-top: 15px; width: 100%;">¡Agendar mi Momento Divino! 💖</button>
            </form>
        </div>
    <% } %>

    <div class="card">
        <h2>🎀 Monitor de Servicios</h2>
        <table>
            <thead>
                <tr>
                    <th>Cliente</th>
                    <th>Servicio</th>
                    <th>Especialista</th>
                    <th>Hora</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${spa.getCitas(rol, username)}">
                    <tr>
                        <td>${c.clienta}</td>
                        <td>${c.servicio}</td>
                        <td><b>${c.empleada}</b></td>
                        <td>${c.hora}</td>
                        <td>
                            <span style="color: <%= "En Cita".equals("${c.estado}") ? "#ff1493" : "#db7093" %>; font-weight: bold;">
                                ${c.estado}
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${rol == 'empleada'}">
                                    <a href="?acc=est&id=${c.id}&n=En Cita" class="btn blue">Empezar</a>
                                    <a href="?acc=est&id=${c.id}&n=Finalizada" class="btn green">Terminar</a>
                                </c:when>
                                <c:when test="${rol == 'clienta' && c.estado == 'Agendada'}">
                                    <a href="?acc=est&id=${c.id}&n=Cancelada" class="btn red">Cancelar 💔</a>
                                </c:when>
                                <c:otherwise>
                                    <small style="color: gray;">Sin acciones</small>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- CHATBOT DE IA EXCLUSIVO PARA CLIENTAS -->
    <% if("clienta".equals(rol)) { %>
        <button class="chat-btn-float" onclick="toggleChat()">💬 Asistente Divina IA ✨</button>

        <div class="chat-container" id="chatBox">
            <div class="chat-header">
                <span>🤖 Divina Beauty Bot</span>
                <span style="cursor:pointer;" onclick="toggleChat()">✖</span>
            </div>
            <div class="chat-body" id="chatMessages">
                <div class="chat-msg msg-bot">
                    ¡Hola <%= user %>! 💖 Soy tu asistente virtual de DIVINAS SPA. ¿En qué puedo ayudarte con tus uñas, pestañas o citas hoy?
                </div>
            </div>
            <div class="chat-footer">
                <input type="text" id="userInput" placeholder="Escribe tu consulta..." onkeypress="handleKey(event)">
                <button class="btn pink" onclick="sendMessage()">Enviar</button>
            </div>
        </div>

        <script>
            function toggleChat() {
                const box = document.getElementById("chatBox");
                box.style.display = (box.style.display === "flex") ? "none" : "flex";
            }

            function handleKey(e) {
                if(e.key === 'Enter') sendMessage();
            }

            function sendMessage() {
                const input = document.getElementById("userInput");
                const text = input.value.trim();
                if(!text) return;

                const msgContainer = document.getElementById("chatMessages");

                const userDiv = document.createElement("div");
                userDiv.className = "chat-msg msg-user";
                userDiv.textContent = text;
                msgContainer.appendChild(userDiv);

                input.value = "";
                msgContainer.scrollTop = msgContainer.scrollHeight;

                setTimeout(() => {
                    const botDiv = document.createElement("div");
                    botDiv.className = "chat-msg msg-bot";
                    botDiv.textContent = responderIA(text.toLowerCase());
                    msgContainer.appendChild(botDiv);
                    msgContainer.scrollTop = msgContainer.scrollHeight;
                }, 600);
            }

            function responderIA(consulta) {
                if(consulta.includes("uña") || consulta.includes("manicura") || consulta.includes("poligel")) {
                    return "💅 Te recomendamos las Uñas Esculpidas o Kapping si buscas durabilidad y un acabado súper femenino. ¡Puedes agendarlas en el formulario!";
                } else if(consulta.includes("pestaña") || consulta.includes("lifting") || consulta.includes("ceja")) {
                    return "👁️ Para resaltar tu mirada, las Extensiones Pelo a Pelo o el Lifting con Tinta te darán un efecto radiante y natural.";
                } else if(consulta.includes("masaje") || consulta.includes("facial") || consulta.includes("limpieza")) {
                    return "💆‍♀️ ¡Momento de relajarte! Nuestros masajes con piedras rosas y faciales de extracto de rosas son perfectos para renovar tu piel.";
                } else if(consulta.includes("agendar") || consulta.includes("cita") || consulta.includes("hora")) {
                    return "📅 Para agendar, solo debes elegir el servicio deseado, seleccionar tu especialista favorita y definir la hora en el panel principal arriba.";
                } else if(consulta.includes("cancelar")) {
                    return "💔 Si necesitas cancelar una cita agendada, haz clic en el botón rojo 'Cancelar' dentro del Monitor de Servicios.";
                } else {
                    return "✨ ¡En DIVINAS SPA estamos para consentirte! Elige un servicio en el menú y agenda tu cita con nuestras especialistas.";
                }
            }
        </script>
    <% } %>

    <!-- SCRIPT OFICIAL DE GOOGLE TRANSLATE -->
    <script type="text/javascript">
        function googleTranslateElementInit() {
            new google.translate.TranslateElement({
                pageLanguage: 'es',
                includedLanguages: 'es,en,fr,pt,it,de',
                layout: google.translate.TranslateElement.InlineLayout.SIMPLE
            }, 'google_translate_element');
        }
    </script>
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

</body>
</html>
