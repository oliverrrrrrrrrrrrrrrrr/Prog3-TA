package pe.edu.pucp.campusstore.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.xml.ws.WebServiceException;
import java.text.SimpleDateFormat;
import java.util.Date;


@WebService(
        serviceName = "ReporteBestSeller",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ReporteBestSeller {

    @WebMethod(operationName = "reporteBestSeller")
    public byte[] reporteBestSeller(
            @WebParam(name = "fechaInicio") String fechaInicio,
            @WebParam(name = "fechaFin") String fechaFin) {

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fi = sdf.parse(fechaInicio);
            Date ff = sdf.parse(fechaFin);
            return ReporteUtil.reporteBestSeller(fechaInicio, fechaFin);
        } catch (Exception ex) {
            throw new WebServiceException("Error al generar el reporte Best Seller", ex);
        }
    }
   
}
