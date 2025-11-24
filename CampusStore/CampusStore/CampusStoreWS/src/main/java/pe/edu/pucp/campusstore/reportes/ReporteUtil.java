package pe.edu.pucp.campusstore.reportes;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

import pe.edu.pucp.campusstore.db.DBFactoryProvider;

public class ReporteUtil {

    public static byte[] invocarReporte(String nombreReporte, HashMap parametros)
            throws SQLException, ClassNotFoundException, IOException {

         byte[] reporte = null;
        Connection conexion = DBFactoryProvider.getManager().getConnection();

        try (InputStream reporteStream = ReporteUtil.class.getClassLoader()
                .getResourceAsStream(nombreReporte + ".jasper")) {

            if (reporteStream == null) {
                throw new RuntimeException("No se encontró el archivo Jasper: " + nombreReporte + ".jasper");
            }

            JasperReport jr = (JasperReport) JRLoader.loadObject(reporteStream);
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, conexion);
            reporte = JasperExportManager.exportReportToPdf(jp);

        } catch (JRException ex) {
            Logger.getLogger(ReporteUtil.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error al generar el reporte: " + nombreReporte, ex);
        }

        return reporte;
    }

    public static byte[] reporteBestSeller(String fechaInicio, String fechaFin)
            throws SQLException, ClassNotFoundException, ParseException, IOException {

        HashMap<String, Object> parametros = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        java.util.Date fi = sdf.parse(fechaInicio);
        java.util.Date ff = sdf.parse(fechaFin);

        java.sql.Date fiSql = new java.sql.Date(fi.getTime());
        java.sql.Date ffSql = new java.sql.Date(ff.getTime());

        parametros.put("fechaInicio", fiSql);
        parametros.put("fechaFin", ffSql);


        return invocarReporte("ReportBestSellers", parametros);
    }

    public static byte[] reporteVentas(String fechaInicio, String fechaFin)
            throws SQLException, ClassNotFoundException, ParseException, IOException {

        HashMap<String, Object> parametros = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fi = sdf.parse(fechaInicio);
            Date ff = sdf.parse(fechaFin);
        parametros.put("fechaInicio", fi);
        parametros.put("fechaFin", ff);


        return invocarReporte("ReporteVentas", parametros);
    }
}