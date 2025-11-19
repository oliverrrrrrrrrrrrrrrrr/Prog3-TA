using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using CampusStoreWeb.CampusStoreWS;

namespace CampusStoreWeb
{
    public class Global : System.Web.HttpApplication
    {
        private static DateTime ultimaVerificacion = DateTime.MinValue;
        private static readonly TimeSpan intervaloVerificacion = TimeSpan.FromMinutes(5); // Verificar cada 5 minutos

        protected void Application_Start(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Verificar y cancelar órdenes expiradas cada cierto intervalo
            // Esto evita ejecutar la verificación en cada solicitud
            if (DateTime.Now - ultimaVerificacion >= intervaloVerificacion)
            {
                try
                {
                    OrdenCompraWSClient ordenCompraWS = new OrdenCompraWSClient();
                    int ordenesCanceladas = ordenCompraWS.cancelarOrdenesExpiradas();
                    
                    if (ordenesCanceladas > 0)
                    {
                        System.Diagnostics.Debug.WriteLine($"Se cancelaron {ordenesCanceladas} órdenes expiradas automáticamente.");
                    }
                    
                    ultimaVerificacion = DateTime.Now;
                }
                catch (Exception ex)
                {
                    // No interrumpir el flujo de la aplicación si hay un error
                    System.Diagnostics.Debug.WriteLine($"Error al cancelar órdenes expiradas: {ex.Message}");
                }
            }
        }
    }
}