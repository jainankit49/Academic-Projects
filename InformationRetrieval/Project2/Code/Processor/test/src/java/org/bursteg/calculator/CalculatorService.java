/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.bursteg.calculator;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author PavanKumar
 */
@WebService(serviceName = "CalculatorService")
public class CalculatorService {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "add")
    public int Add(@WebParam(name="a") int a,
                       @WebParam(name="b") int b)
        {
            return a + b;
        }
}
