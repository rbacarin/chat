<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chat.aspx.cs" Inherits="chat.chat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chat SignalR </title>
    <style type="text/css">
        .container {
            background-color: #99CCFF;
            border: thick solid #808080;
            padding: 20px;
            margin: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <input type="text" id="mensagem" />
        <input type="button" id="enviamensagem" value="Send" />
        <input type="hidden" id="exibenome" />
        <ul id="discussion">
        </ul>
    </div>
    <script src="Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-1.1.3.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            var chat = $.connection.chatHub;
            chat.client.broadcastMessage = function (nome, message) {
                var encodednome = $('<div />').text(nome).html();
                var encodedMsg = $('<div />').text(message).html();
                $('#discussion').append('<li><strong>' + encodednome
                    + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
            };
            $('#exibenome').val(prompt('Informe o seu nome :', ''));
            $('#mensagem').focus();
            $.connection.hub.start().done(function () {
                $('#enviamensagem').click(function () {
                    chat.server.send($('#exibenome').val(), $('#mensagem').val());
                    $('#mensagem').val('').focus();
                });
            });
        });
    </script>
</body>
</html>