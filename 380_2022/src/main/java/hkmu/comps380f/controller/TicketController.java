package hkmu.comps380f.controller;

import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.service.AttachmentService;
import hkmu.comps380f.service.TicketService;
import hkmu.comps380f.view.DownloadingView;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/ticket")
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private AttachmentService attachmentService;

    // Controller methods, Form object, ...
    @GetMapping({"", "/index"})
    public String index(ModelMap model) {
        model.addAttribute("ticketDatabase", ticketService.getTickets());
        return "index";
    }

    @GetMapping("/addCourseMaterial")
    public ModelAndView addCourseMaterial() {
        return new ModelAndView("mcPollsPage", "ticketForm", new Form());
    }

    public static class Form {

        private String subject;
        private String body;
        private List<MultipartFile> attachments;

        // Getters and Setters of subject, body, attachments
        public String getSubject(){
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }

    @PostMapping("/addCourseMaterial")
    public String addCourseMaterial(Form form, Principal principal) throws IOException {
        long ticketId = ticketService.createTicket(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return "redirect:/ticket/FileInfoView/" + ticketId;
    }

    @GetMapping("/FileInfoView/{ticketId}")
    public String view(@PathVariable("ticketId") long ticketId, ModelMap model) {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null) {
            return "redirect:/ticket/CourseMaterial";
        }
        model.addAttribute("ticket", ticket);
        return "FileInfoView";
    }

    @GetMapping("/{ticketId}/attachment/{attachment:.+}")
    public View download(@PathVariable("ticketId") long ticketId,
            @PathVariable("attachment") String name) {

        Attachment attachment = attachmentService.getAttachment(ticketId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/ticket/CourseMaterial", true);
    }

    @GetMapping("/{ticketId}/delete/{attachment:.+}")
    public String deleteAttachment(@PathVariable("ticketId") long ticketId,
            @PathVariable("attachment") String name) throws AttachmentNotFound {
        ticketService.deleteAttachment(ticketId, name);
        return "redirect:/ticket/editCourseMaterial/" + ticketId;
    }

    @GetMapping("/editCourseMaterial/{ticketId}")
    public ModelAndView showEdit(@PathVariable("ticketId") long ticketId,
            Principal principal, HttpServletRequest request) {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getCustomerName()))) {
            return new ModelAndView(new RedirectView("/ticket/CourseMaterial", true));
        }

        ModelAndView modelAndView = new ModelAndView("editCourseMaterial");
        modelAndView.addObject("ticket", ticket);

        Form ticketForm = new Form();
        ticketForm.setSubject(ticket.getSubject());
        ticketForm.setBody(ticket.getBody());
        modelAndView.addObject("ticketForm", ticketForm);

        return modelAndView;
    }

    @PostMapping("/editCourseMaterial/{ticketId}")
    public String edit(@PathVariable("ticketId") long ticketId, Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, TicketNotFound {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getCustomerName()))) {
            return "redirect:/ticket/CourseMaterial";
        }

        ticketService.updateTicket(ticketId, form.getSubject(),
                form.getBody(), form.getAttachments());
        return "redirect:/ticket/FileInfoView/" + ticketId;
    }

    @GetMapping("/delete/{ticketId}")
    public String deleteTicket(@PathVariable("ticketId") long ticketId)
            throws TicketNotFound {
        ticketService.delete(ticketId);
        return "redirect:/ticket/CourseMaterial";
    }

}
