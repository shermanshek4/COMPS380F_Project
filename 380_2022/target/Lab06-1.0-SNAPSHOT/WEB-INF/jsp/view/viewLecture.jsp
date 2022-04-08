<!DOCTYPE html>
<html>
    <head>
        <title>View Lectures</title>
    </head>
    <body>
        <a href="<c:url value="/course?action=emptyLecture" />">Empty Lecture</a>
        <h1>View Lecture</h1>
        <a href="<c:url value="/course" />">Lecture List</a><br /><br />
        <c:choose>
            <c:when test="${empty lecture}">
               You didn't select any lectures.
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="lectureItem" items="${lecture}">
                        <li>${lectures[lectureItem.key]} (Count: ${lectureItem.value})</li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </body>
</html>
