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

        <h2>File #${ticketId}: <c:out value="${ticket.subject}" /></h2>
        <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.customerName}'">
            [<a href="<c:url value="/ticket/editCourseMaterial/${ticketId}" />">Edit</a>]
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">
            [<a href="<c:url value="/ticket/delete/${ticketId}" />">Delete</a>]
        </security:authorize>
        <br /><br />
        <i>User - <c:out value="${ticket.customerName}" /></i><br /><br />
        <c:out value="${ticket.body}" /><br /><br />
        <c:if test="${ticket.numberOfAttachments > 0}">
            Course Material:
            <c:forEach items="${ticket.attachments}" var="attachment"
                       varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/ticket/${ticketId}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>
        <a href="<c:url value="/ticket/CourseMaterial" />">Return to Course Material list</a>
    </body>
</html>