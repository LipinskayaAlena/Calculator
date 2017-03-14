package by.lipinskaya.controller;

import by.lipinskaya.model.Operation;
import by.lipinskaya.service.OperationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Asus on 10.03.2017.
 */

@Controller
public class OperationController {
    @Autowired
    OperationService operationService;
    ///OperationRepository rp;


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView start() {
        ModelAndView modelAndView = new ModelAndView("../../index");
        return modelAndView;
    }

    @RequestMapping(value = "/operation/new", method = RequestMethod.POST)
    @ResponseBody
    public Operation newOperation(@ModelAttribute("operation") Operation operation, HttpServletRequest request) {
        boolean step0 = (operation.getAmount_receipts() + operation.getAmount_income()) >= operation.getAmount_entrepreneurial_activity();
        if (operation.getJob_availability() == 1 && step0) {
            float result = (operation.getAmount_receipts() + operation.getAmount_income() - operation.getAmount_entrepreneurial_activity()) * 0.16f;
            operation.setResult(result);
            operationService.addOperation(operation);

        } else if (operation.getJob_availability() == 0 && step0) {
            float step1, step2, step3, step4 = 0, step5, step6, result = 0;
            //1 step
            step1 = operation.getAmount_receipts() + operation.getAmount_income();

            //2 step
            if ((step1 - operation.getAmount_entrepreneurial_activity()) <= 15020000)
                step2 = step1 - (830000 * operation.getPeriod());
            else
                step2 = step1;
            step2 = (step2 < 0)? 0: step2;

            //3 step
            if(operation.getBenefits_availability() == 1)
                step3 = step2 - (1170000 * operation.getPeriod());
            else
                step3 = step2;
            step3 = (step3 < 0)? 0: step3;

            //4 step
            if(operation.getLonely() == 1 && operation.getNumber_child() > 0 &&
                    operation.getNumber_dependent() > 0)
                step4 = step3 - operation.getPeriod() * 460000 * (operation.getNumber_child() + operation.getNumber_dependent());
            else if(operation.getLonely() == 0 && operation.getNumber_child() == 1 &&
                    operation.getNumber_child_invalid() == 0 && operation.getNumber_dependent() > 0)
                step4 = step3 - operation.getPeriod() * 240000 * (operation.getNumber_child() + operation.getNumber_dependent());
            else if(operation.getLonely() == 0 && operation.getNumber_child() == 1 &&
                    operation.getNumber_child_invalid() == 1 && operation.getNumber_dependent() > 0)
                step4 = step3 - operation.getPeriod() * ((operation.getNumber_child() * 460000) + (operation.getNumber_dependent()*240000));
            else if(operation.getLonely() == 0 && operation.getNumber_child() > 1  && operation.getNumber_dependent() > 0)
                step4 = step3 - operation.getPeriod() * 460000 * (operation.getNumber_child() + operation.getNumber_dependent());
            step4 = (step4 < 0)? 0: step4;

            //5 step
            if(operation.getAmount_contribution() <= 16000000)
                step5 = step4 - operation.getAmount_contribution();
            else
                step5 = step4 - 16000000;
            step5 = (step5 < 0)? 0: step5;

            //6 step
            step6 = step5 - (operation.getAmount_education() + operation.getAmount_building() + operation.getAmount_entrepreneurial_activity());
            step6 = (step6 < 0)? 0: step6;
            //7 step
            result = step6 * 0.16f;
            operation.setResult(result);
            operationService.addOperation(operation);
        }
        return operation;
    }


    @RequestMapping(value = "/calculator")
    public String startCalculator() {
        return "calculator";
    }

    @RequestMapping(value = "/operation", method = RequestMethod.GET)
    @ResponseBody
    public List<Operation> newOperation(HttpServletRequest request) {
        List<Operation> operations = new ArrayList<Operation>();
        operations = operationService.getAllOperations();

        return operations;
    }



}