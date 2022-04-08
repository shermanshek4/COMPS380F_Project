<!DOCTYPE html>
<html>
    <head>
        <title>View MCPolls</title>
    </head>
    <body>
        <a href="<c:url value="/course?action=emptyMCPoll" />">Empty MCPolls</a>
        <h1>View MCPolls</h1>
        <a href="<c:url value="/course" />">MCPolls List</a><br /><br />
        <c:choose>
            <c:when test="${empty mcpoll}">
               You didn't select any MC Questions.
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="mcpollItem" items="${mcpoll}">
                        <li>${mcpolls[mcpollItem.key]} (Count: ${mcpollItem.value})</li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </body>
</html>
