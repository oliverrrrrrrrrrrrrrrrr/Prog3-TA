package pe.edu.pucp.campusstore.reportes;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import jakarta.jws.WebMethod;
import jakarta.jws.WebService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import net.sf.jasperreports.engine.JRException;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;
// Importa tu clase de conexión a BD
import pe.edu.pucp.campusstore.db.DBManager;
/**
 *
 * @author AXEL
 */

@WebServlet(name = "ReporteBestSellers", urlPatterns = {"/reportes/ReporteBestSellers"})
public class ReporteBestSellers extends HttpServlet {

    private final String NOMBRE_REPORTE = "reportes/ReporteBestSellers.jasper";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");

        InputStream reporte = getClass().getClassLoader().getResourceAsStream(NOMBRE_REPORTE);
        if (reporte == null) {
            throw new FileNotFoundException("No se encontro el reporte: " + NOMBRE_REPORTE);
        }

        Map<String, Object> parametros = new HashMap<>();

        String fechaInicioStr = request.getParameter("fechaInicio");
        String fechaFinStr = request.getParameter("fechaFin");

        if (fechaInicioStr == null || fechaFinStr == null
                || fechaInicioStr.isBlank() || fechaFinStr.isBlank()) {
            throw new RuntimeException("Las fechas 'fechaInicio' y 'fechaFin' son requeridas.");
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);

            java.util.Date fechaInicioUtil = sdf.parse(fechaInicioStr);
            java.util.Date fechaFinUtil = sdf.parse(fechaFinStr);

            parametros.put("fechaInicio", fechaInicioUtil);
            parametros.put("fechaFin", fechaFinUtil);
        } catch (ParseException e) {
            throw new RuntimeException("Formato de fecha inválido. Usa yyyy-MM-dd", e);
        }

        // 3. Ejecutar el reporte normalmente
        try (Connection conn = DBFactoryProvider.getManager().getConnection()) {
            JasperPrint jp = JasperFillManager.fillReport(reporte, parametros, conn);
            JasperExportManager.exportReportToPdfStream(jp, response.getOutputStream());
        }
        catch (SQLException | ClassNotFoundException | JRException ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                    "Error al generar el reporte: " + ex.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
