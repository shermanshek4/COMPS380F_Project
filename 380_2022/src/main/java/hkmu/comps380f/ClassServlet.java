package hkmu.comps380f;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "classServlet", urlPatterns = {"/course"})
public class ClassServlet extends HttpServlet {

    private final Map<Integer, String> lectures = new ConcurrentHashMap<>();
    private final Map<Integer, String> mcpolls = new ConcurrentHashMap<>();

    public ClassServlet() {
        this.lectures.put(1, "S333F");
        this.lectures.put(2, "S350F");
        this.lectures.put(3, "S381F");
        this.lectures.put(4, "S382F");
        this.lectures.put(5, "S380F: Web Applications");

        this.mcpolls.put(6, "MC1...?");
        this.mcpolls.put(7, "MC2?");
        this.mcpolls.put(8, "MC3?");
        this.mcpolls.put(9, "MC4?");
        this.mcpolls.put(10, "MC5?");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "browse";
        }

        switch (action) {
            case "addToCart":
                this.addToCart(request, response);
                break;
            case "viewLecture":
                this.viewLecture(request, response);
                break;
            case "viewMCPoll":
                this.viewMCPoll(request, response);
                break;
            case "emptyLecture":
                this.emptyLecture(request, response);
                break;
            case "emptyMCPoll":
                this.emptyMCPoll(request, response);
                break;
            case "browse":
            default:
                this.browse(request, response);
                break;
        }
    }

    // Defining other methods ...
    private void viewLecture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("lectures", this.lectures);
        request.getRequestDispatcher("/WEB-INF/jsp/view/viewLecture.jsp")
                .forward(request, response);
    }

    private void viewMCPoll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("mcpolls", this.mcpolls);
        request.getRequestDispatcher("/WEB-INF/jsp/view/viewMCPoll.jsp")
                .forward(request, response);
    }

    private void browse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("lectures", this.lectures);
        request.getRequestDispatcher("/WEB-INF/jsp/view/browse.jsp")
                .forward(request, response);

        request.setAttribute("mcpolls", this.mcpolls);
        request.getRequestDispatcher("/WEB-INF/jsp/view/browse.jsp")
                .forward(request, response);

    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (Exception e) {
            response.sendRedirect("course");
            return;
        }

        HttpSession session = request.getSession();
        if (session.getAttribute("lecture") == null) {
            session.setAttribute("lecture", new ConcurrentHashMap<>());
 session.setAttribute("mcpoll", new ConcurrentHashMap<>());
        }

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart
                = (Map<Integer, Integer>) session.getAttribute("lecture");
        if (!cart.containsKey(productId)) {
            cart.put(productId, 0);
        }
        cart.put(productId, cart.get(productId) + 1);

        response.sendRedirect("course?action=viewLecture");
    }

    private void emptyLecture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("lecture");
        response.sendRedirect("course?action=viewLecture");
    }

    private void emptyMCPoll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("mcpoll");
        response.sendRedirect("course?action=viewMCPoll");
    }
}
