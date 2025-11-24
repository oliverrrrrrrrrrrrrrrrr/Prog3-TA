/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.reportes;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;

/**
 *
 * @author oliver
 */
@WebService(
        serviceName = "ReporteWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ReporteWS {

    private static byte[] invocarReporte(String nombreReporte, HashMap<String, Object> parametros)
            throws SQLException, ClassNotFoundException, IOException {

        byte[] reporte = null;
        Connection conexion = DBFactoryProvider.getManager().getConnection();

        String ruta = "reportes/" + nombreReporte + ".jasper";
        try (InputStream is = ReporteWS.class.getClassLoader().getResourceAsStream(ruta)) {

            if (is == null) {
                throw new RuntimeException("No se encontró el reporte en el classpath: " + ruta);
            }

            JasperReport jr = (JasperReport) JRLoader.loadObject(is);
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, conexion);

            System.out.println("[ReporteWS] Páginas generadas: " + jp.getPages().size());

            reporte = JasperExportManager.exportReportToPdf(jp);

        } catch (JRException ex) {
            System.getLogger(ReporteWS.class.getName())
                    .log(System.Logger.Level.ERROR, (String) null, ex);
        } finally {
            try {
                conexion.close();
            } catch (SQLException ex) {
                System.getLogger(ReporteWS.class.getName())
                        .log(System.Logger.Level.ERROR, (String) null, ex);
            }
        }
        return reporte;
    }

    @WebMethod(operationName = "reporteVentas")
    public byte[] reporteVentas(
            @WebParam(name = "fechaIni") String fechaIni,
            @WebParam(name = "fechaFin") String fechaFin
    ) throws SQLException, ClassNotFoundException, IOException {

        try {
            // 1. Parsear los String a java.util.Date
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);

            java.util.Date fiUtil = sdf.parse(fechaIni);
            java.util.Date ffUtil = sdf.parse(fechaFin);

            // 2. Opcional: pasarlos a java.sql.Date si tu query los usa directamente
            java.sql.Date fiSql = new java.sql.Date(fiUtil.getTime());
            java.sql.Date ffSql = new java.sql.Date(ffUtil.getTime());

            HashMap<String, Object> parametros = new HashMap<>();
            // Usa fiSql/ffSql o fiUtil/ffUtil según el tipo de parámetro en Jasper
            parametros.put("fechaInicio", fiSql);
            parametros.put("fechaFin", ffSql);

            return invocarReporte("ReporteVentas", parametros);

        } catch (java.text.ParseException ex) {
            throw new RuntimeException("Formato de fecha inválido. Usa yyyy-MM-dd", ex);
        }
    }
}
