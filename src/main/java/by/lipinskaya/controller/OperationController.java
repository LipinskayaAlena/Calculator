package by.lipinskaya.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Asus on 10.03.2017.
 */

//@RestController
//@RequestMapping("/operation")
@Controller
public class OperationController {
    //@Autowired
    ///OperationRepository rp;

    //@RequestMapping("/findall")
    //@ResponseBody
    //public List<Operation> findall() {
    //    return rp.findAll();
    //}

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView getLogin() {
        ModelAndView modelAndView = new ModelAndView("../../index");
        modelAndView.addObject("message", " ALENA");

        return modelAndView;
    }

    @RequestMapping(value="/calculator", method = RequestMethod.GET)
    public ModelAndView calculator() {
        ModelAndView modelAndView = new ModelAndView("calculator");
        modelAndView.addObject("message","ALENA!!");
        System.out.println("MESSSAGE!!!");
        return modelAndView;
    }



    //@RequestMapping("/calculator")
    //public String calculator(Map<String, Object> model) {
    //    model.put("message", " ALENA");
    //    return "calculator";
    //}
}
