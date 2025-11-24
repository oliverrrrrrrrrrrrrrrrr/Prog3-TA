package pe.edu.pucp.campusstore.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.xml.ws.WebServiceException;


@WebService(
        serviceName = "ReporteBestSeller",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ReporteBestSeller {

    @WebMethod(operationName = "reporteBestSeller")
    public byte[] reporteBestSeller(
        @WebParam(name = "fechaInicio") String fechaInicio,
        @WebParam(name = "fechaFin") String fechaFin
    ) {
        try {
            return ReporteUtil.reporteBestSeller(fechaInicio, fechaFin);
        } catch (Exception ex) {
            throw new WebServiceException("Error al generar reporte BestSeller", ex);
        }
    }
   
}
