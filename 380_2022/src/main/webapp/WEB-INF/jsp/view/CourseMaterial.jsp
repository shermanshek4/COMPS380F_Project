<!DOCTYPE html>
<html>
<head>
    <title>Course Material</title>
</head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<h2>Computer Science</h2>
<a href="<c:url value="/ticket/addCourseMaterial" />">Upload a File</a><br /><br />
<c:choose>
    <c:when test="${fn:length(ticketDatabase) == 0}">
        <i>There are nothings in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${ticketDatabase}" var="entry">
            File ${entry.key}:
            <a href="<c:url value="/ticket/FileInfoView/${entry.key}" />">
               <c:out value="${entry.value.subject}" /></a>
            (User: <c:out value="${entry.value.customerName}" />)
            <security:authorize access="hasRole('ADMIN') or principal.username=='${entry.value.customerName}'">
                [<a href="<c:url value="/ticket/editCourseMaterial/${entry.key}" />">Edit</a>]
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/ticket/delete/${entry.key}" />">Delete</a>]
            </security:authorize>
            <br />
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
