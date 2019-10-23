<%-- 
    Document   : playlist
    Created on : Jul 24, 2019, 12:24:41 AM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Jura" />
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Varela+Round" /><link rel='stylesheet' href='//fonts.googleapis.com/css?family=Jura' type='text/css' /> 
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Aministrator Panel | Moply</title>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <style>
            .wrap{
                min-height: 800px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 20px;
                font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;  
                background-image: url('img/formbackground/adminbg.jpg');
            }
            .wrap hr{
                border-top: 0.2px solid lavender;
                margin: 1% 1% 1% 1%;
            }

            a {
                color: #0c5460;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                font-size: 20px;
            }

            th, td {
                text-align: left;
                padding: 20px;
            }

            tr:nth-child(even){background-color: #f2f2f2}

            th {
                background-color: #4CAF50;
                color: white;
            }

            .page_title{
                color:#1f7f5c;
                font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Varela Round; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Varela Round; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px;
            }
            .entities_list li{
                padding-bottom: 30px;
                font-size: 20px;
            }
            .entities_list{
                margin-left: 20px;
            }
            .wrap img{
                width: 30px;
                height: 30px;
                vertical-align: middle;
            }

        </style>
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="page_title"><h2>My Playlists </h2></div>
                        <hr>
                        <br>
                        <a href="createplaylist"><img src="img/icon/create_playlist.png"/>Create new playlist</a>
                        <table class="playlist_table">
                            <tr>
                                <th>Playlist Name</th>
                                <th>Functions</th>
                            </tr>
                        <c:forEach items="${playlists}" var="p">
                            <tr>
                                <td><a href="play?playlistid=${p.getId()}">${p.getName()}</a></td>
                                <td>
                                    <a href="editplaylist?playlistid=${p.getId()}"><img src="img/icon/setting_icon.png"/></a>
                                    <a onclick="return confirmAction();" href="deleteplaylist?playlistid=${p.getId()}"><img src="img/icon/delete_icon.png"/></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
    <SCRIPT>
        function confirmAction() {
            return confirm("Are you sure want to continue?");
        }
    </SCRIPT>
</html>
