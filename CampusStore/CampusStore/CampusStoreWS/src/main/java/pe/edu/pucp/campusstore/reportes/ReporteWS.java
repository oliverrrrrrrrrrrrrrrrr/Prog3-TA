/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.reportes;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import jakarta.xml.ws.WebServiceException;


@WebService(
        serviceName = "ReporteWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ReporteWS {

   @WebMethod(operationName = "reporteVentas")
    public byte[] reporteVentas(
            @WebParam(name = "fechaInicio") String fechaInicio,
            @WebParam(name = "fechaFin") String fechaFin) {

        try {
            return ReporteUtil.reporteVentas(fechaInicio, fechaFin);
        } catch (Exception ex) {
            throw new WebServiceException("Error al generar el reporte de Ventas", ex);
        }
    }
    
}
