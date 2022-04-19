<!DOCTYPE html>
<html>
<head>
    <title>Online Course Website</title>
</head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<h2>Multiple-choice polls</h2>
    <form:form method="POST" enctype="multipart/form-data"
                             modelAttribute="ticketForm">
        <form:label path="subject">Question:</form:label><br />
        <form:input type="text" path="subject" /><br /><br />
        4 MC options:<br /><br />
        <form:label path="body">Comments:</form:label><br />
        <form:textarea path="body" rows="5" cols="30" /><br /><br />
        <b>Attachments</b><br />
        <input type="file" name="attachments" multiple="multiple" /><br /><br />
        <input type="submit" value="Submit"/>
    </form:form>
</body>
</html>
