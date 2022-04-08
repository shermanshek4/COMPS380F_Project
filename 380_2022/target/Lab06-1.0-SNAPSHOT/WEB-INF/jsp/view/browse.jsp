
<!DOCTYPE html>
<html>
    <head>
        <title>Computer Science</title>
    </head>
    <body>
        <h1>Computer Science</h1>
        <a href="<c:url value="/course?action=viewLecture" />">View Lecture</a><br /><br />
        
        <c:forEach var="lecture" items="${lectures}">
            <a href="<c:url value="/course">
                   <c:param name="action" value="addToCart" />
                   <c:param name="productId" value="${lecture.key}" />
               </c:url>">${lecture.value}</a><br />
        </c:forEach><p />

        <a href="<c:url value="/course?action=viewMCPoll" />">View MC Polls</a><br /><br />
        
        <c:forEach var="mcpoll" items="${mcpolls}">
            <a href="<c:url value="/course">
                   <c:param name="action" value="addToCart" />
                   <c:param name="productId" value="${mcpoll.key}" />
               </c:url>">${mcpoll.value}</a><br />
        </c:forEach>
    </body>
</html>