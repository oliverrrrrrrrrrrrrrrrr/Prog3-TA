package pe.edu.pucp.campusstore.reportes;

import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;
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
            throws SQLException, ClassNotFoundException {

        byte[] reporte = null;
        Connection conexion = DBFactoryProvider.getManager().getConnection();
        String nombreRecurso = "/" + nombreReporte + ".jasper";

        try {
            JasperReport jr = (JasperReport) JRLoader.loadObject(
                    ReporteUtil.class.getResource(nombreRecurso)
            );
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, conexion);
            reporte = JasperExportManager.exportReportToPdf(jp);

        } catch (JRException ex) {
            Logger.getLogger(ReporteUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reporte;
    }

    public static byte[] reporteBestSeller(String fechaInicio, String fechaFin)
            throws SQLException, ClassNotFoundException {

        HashMap<String, Object> parametros = new HashMap<>();

        parametros.put("FECHA_INICIO", fechaInicio);
        parametros.put("FECHA_FIN", fechaFin);

        URL url = ReporteUtil.class.getClassLoader().getResource("myholylogo.png");
        parametros.put("logopath", url);

        return invocarReporte("ReporteBestSellers", parametros);
    }

    public static byte[] reporteVentas(String fechaInicio, String fechaFin)
            throws SQLException, ClassNotFoundException {

        HashMap<String, Object> parametros = new HashMap<>();

        parametros.put("FECHA_INICIO", fechaInicio);
        parametros.put("FECHA_FIN", fechaFin);

        URL url = ReporteUtil.class.getClassLoader().getResource("myholylogo.png");
        parametros.put("logopath", url);

        return invocarReporte("ReporteVentas", parametros);
    }
}