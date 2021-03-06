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

<h2>Computer Science</h2>
<security:authorize access="hasRole('LECTURER')">    
    <a href="<c:url value="/user" />">Manager Users</a><br /><br />
</security:authorize>
<a href="<c:url value="/ticket/lecture" />">Lectures</a><br /><br />
<a href="<c:url value="/ticket/create" />">Multiple-Choice polls</a><br /><br />
<c:choose>
    <c:when test="${fn:length(ticketDatabase) == 0}">
        <i>There are no users in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${ticketDatabase}" var="ticket">
            Ticket ${ticket.id}:
            <a href="<c:url value="/ticket/view/${ticket.id}" />">
                <c:out value="${ticket.subject}" /></a>
            (customer: <c:out value="${ticket.customerName}" />)
            <security:authorize access="hasRole('ADMIN') or
                                principal.username=='${ticket.customerName}'">
                [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">            
                [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
            </security:authorize>
            <br /><br />
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
