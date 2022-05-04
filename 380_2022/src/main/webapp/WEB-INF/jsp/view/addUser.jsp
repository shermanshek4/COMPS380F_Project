<!DOCTYPE html>
<html>
<head><title>Online Course Website</title></head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
<br />
<a href="<c:url value="/user" />">Cancel</a>

<h2>Create a User</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="ticketUser">
    <form:label path="username">Username</form:label><br/>
    <form:input type="text" path="username" /><br/><br/>
    <form:label path="password">Password</form:label><br/>
    <form:input type="text" path="password" /><br/><br/>
    
    <form:label path="fullname">Fullname</form:label><br/>
    <form:input type="text" path="fullname" /><br/><br/>
    <form:label path="address">Address</form:label><br/>
    <form:input type="text" path="address" /><br/><br/>
    <form:label path="phonenumber">Phonenumber</form:label><br/>
    <form:input type="text" path="phonenumber" /><br/><br/>
    
    <form:label path="roles">Roles</form:label><br/>
    <form:checkbox path="roles" value="ROLE_STUDENT" />STUDENT
    <form:checkbox path="roles" value="ROLE_LECTURER" />LECTURER
    <br /><br />
    <input type="submit" value="Add User"/>
</form:form>
</body>
</html>
