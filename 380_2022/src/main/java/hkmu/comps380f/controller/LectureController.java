package hkmu.comps380f.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ticket")
public class LectureController {

    @GetMapping("/CourseMaterial")
    public String lecture() {
        return "CourseMaterial";
    }
}
