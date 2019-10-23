<%-- 
    Document   : editplaylist
    Created on : Jul 25, 2019, 1:14:46 AM
    Author     : quoct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Jura" />
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Varela+Round" /><link rel='stylesheet' href='//fonts.googleapis.com/css?family=Jura' type='text/css' /> 
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Edit playlist | Moply</title>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <style>
            .wrap{
                min-height: 600px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 20px;
                font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;  
                background-image: url('img/formbackground/login.jpg'); 
            }
            .wrap hr{
                border-top: 0.2px solid lavender;
                margin: 1% 1% 1% 1%;
            }

            a {
                color: #0c5460;
            }
            table{
                border-spacing: 15px;
            }

            .page_title{
                color:#1f7f5c;
                font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Varela Round; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Varela Round; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px
            }
            .entities_list li{
                padding-bottom: 30px;
                font-size: 20px;
            }
            .entities_list{
                margin-left: 20px;
            }
            select#soflow, select#soflow-color {
                -webkit-appearance: button;
                -webkit-border-radius: 2px;
                -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
                -webkit-padding-end: 20px;
                -webkit-padding-start: 2px;
                -webkit-user-select: none;
                background-image: url(http://i62.tinypic.com/15xvbd5.png), -webkit-linear-gradient(#FAFAFA, #F4F4F4 40%, #E5E5E5);
                background-position: 97% center;
                background-repeat: no-repeat;
                border: 1px solid #AAA;
                color: #555;
                font-size: inherit;
                margin: 20px;
                overflow: hidden;
                padding: 5px 10px;
                text-overflow: ellipsis;
                white-space: nowrap;
                width: 225px;
            }

            select#soflow-color {
                color: #fff;
                background-image: url(http://i62.tinypic.com/15xvbd5.png), -webkit-linear-gradient(#779126, #779126 40%, #779126);
                background-color: #779126;
                -webkit-border-radius: 20px;
                -moz-border-radius: 20px;
                border-radius: 20px;
                padding-left: 15px;
            }
            td input{
                border-radius: 10px;
                border: 1px solid #999;
                padding-top: 5px;
                padding-bottom: 5px;
                font-size: 20px;
                margin-left: 20px;
            }
            .add_form{
                margin: 3% 0 0 30%;
            }
            #saveButton{
                width: 30%;
                background-color: rgb(64, 151, 119);
                border: none;
                color: white;
                border-radius: 5px;
                margin-left: 35%;
            }
            #saveButton:hover{
                background-color: #1f7f5c;
            }
            #saveButton:active{
                background-color: #232323;
            }
            table{
                background-color: #ebebeb;
                border-spacing: 30px;
                border-radius: 20px;
                text-align: left;
                font-size: 20px;
            }
        </style>
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="page_title"><h2><b>Edit playlist</b></h2></div>
                        <hr>
                        <br>
                        <form class="add_form" method="post" action="editplaylist" name="form" onsubmit="return validate();">
                            <table>
                                <tr>
                                    <td>Change Playlist name:</td>
                                    <td><input type="text" name="playlistname">
                                        <br>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input id="saveButton" type="submit" value="Save">
                                        <input hidden value="${playlistid}" name="playlistid"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
    <script>
        function validate() {
            var form = document.forms["form"];
            var name = form["playlistname"].value;
            var Reg=/^[a-zA-Z0-9]+$/;
            if(!Reg.test(name)){
                alert("Playlist name cannot be blank or contain special characters!");
                return false;
            }else{
                return true;
            }
        }
    </script>
</html>

