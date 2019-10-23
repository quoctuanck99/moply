<%-- 
    Document   : songlist
    Created on : Jul 23, 2019, 11:23:30 AM
    Author     : quoct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../../template/nagivator/nagivatorBar.jsp"></jsp:include>
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

        </style>
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="page_title"><h2>Aministrator Panel </h2></div>
                        <hr>
                        <br>
                        <ul class="entities_list">
                            <li><a href="listsongs">All songs</a></li>
                            <li><a href="createartist">Create new Artist</a></li>
                            <li><a href="#">Create new category</a></li>
                            <li><a href="#">Create new country</a></li>
                            <li><a href="#">Create new language</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        <jsp:include page="../../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>