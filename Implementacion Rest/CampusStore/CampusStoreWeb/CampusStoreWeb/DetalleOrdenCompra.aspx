<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleOrdenCompra.aspx.cs" Inherits="CampusStoreWeb.DetalleOrdenCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Breadcrumb personalizado */
        .breadcrumb-custom {
            background-color: #f8f9fa;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        
        .breadcrumb-custom .breadcrumb {
            background-color: transparent;
            margin-bottom: 0;
            padding: 0;
        }
        
        .breadcrumb-custom .breadcrumb-item {
            font-size: 14px;
            color: #5F6C72;
        }
        
        .breadcrumb-custom .breadcrumb-item.active {
            color: var(--primary-orange);
            font-weight: 500;
        }
        
        .breadcrumb-custom .breadcrumb-item a {
            color: #5F6C72;
            text-decoration: none;
        }
        
        .breadcrumb-custom .breadcrumb-item a:hover {
            color: var(--primary-orange);
        }
        
        /* Botón volver */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #5F6C72;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            transition: color 0.3s;
        }
        
        .btn-back:hover {
            color: var(--primary-orange);
        }
        
        /* Card principal */
        .detalle-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        
        .detalle-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid #E4E7E9;
        }
        
        .detalle-title h1 {
            font-size: 28px;
            font-weight: 600;
            color: #191C1F;
            margin-bottom: 8px;
        }
        
        .detalle-id {
            color: #5F6C72;
            font-size: 14px;
        }
        
        .detalle-actions {
            display: flex;
            gap: 12px;
        }
        
        .btn-edit-detail, .btn-cancel-detail {
            padding: 10px 24px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            border: none;
        }
        
        .btn-edit-detail {
            background-color: var(--primary-orange);
            color: white;
        }
        
        .btn-edit-detail:hover {
            background-color: #d86f28;
            color: white;
        }
        
        .btn-cancel-detail {
            background-color: #FFE5E5;
            color: #EE5858;
        }
        
        .btn-cancel-detail:hover {
            background-color: #ffcccc;
        }
        
        /* Grid de información */
        .detalle-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .detalle-info {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #E4E7E9;
        }
        
        .info-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        
        .info-label {
            color: #5F6C72;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .info-value {
            color: #191C1F;
            font-size: 16px;
            font-weight: 500;
        }
        
        .precio-value {
            color: var(--primary-orange);
            font-size: 24px;
            font-weight: 700;
        }
        
        .status-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-pendiente {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }
        
        .status-pagado {
            background-color: #EAF7ED;
            color: #2DB224;
        }
        
        .status-enviado {
            background-color: #E8F4FD;
            color: #2DA5F3;
        }
        
        .status-entregado {
            background-color: #EAF7ED;
            color: #2DB224;
        }
        
        .status-cancelado {
            background-color: #FFE5E5;
            color: #EE5858;
        }
        
        /* Mensaje de error */
        .error-message {
            background-color: #FFE5E5;
            color: #EE5858;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .error-message i {
            font-size: 24px;
        }

        /* Formulario de edición */
        .form-edicion {
            background-color: #F9FAFB;
            border: 2px solid var(--primary-orange);
            border-radius: 8px;
            padding: 30px;
            margin-top: 30px;
        }

        .form-edicion h3 {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-edicion h3 i {
            color: var(--primary-orange);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group-full {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            color: #475156;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            font-size: 14px;
            color: #191C1F;
            background-color: white;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-orange);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #E4E7E9;
        }

        .btn-form {
            padding: 12px 30px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-transform: uppercase;
        }

        .btn-guardar {
            background-color: var(--primary-orange);
            color: white;
        }

        .btn-guardar:hover {
            background-color: #d86f28;
        }

        .btn-cancelar-edit {
            background-color: #E4E7E9;
            color: #5F6C72;
        }

        .btn-cancelar-edit:hover {
            background-color: #d1d5d9;
        }

        /* Sección de productos */
        .productos-section {
            background-color: #F9FAFB;
            border: 2px solid #E4E7E9;
            border-radius: 8px;
            padding: 24px;
            margin-top: 30px;
        }

        .productos-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .productos-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .productos-header i {
            color: var(--primary-orange);
            font-size: 22px;
        }

        .productos-tabla {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 4px;
            overflow: hidden;
        }

        .productos-tabla thead th {
            background-color: #F2F4F5;
            color: #475156;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            padding: 12px 16px;
            text-align: left;
            border-bottom: 2px solid #E4E7E9;
        }

        .productos-tabla tbody td {
            padding: 12px 16px;
            color: #191C1F;
            font-size: 14px;
            border-bottom: 1px solid #E4E7E9;
        }

        .productos-tabla tbody tr:last-child td {
            border-bottom: none;
        }

        .productos-tabla tbody tr:hover {
            background-color: #F9FAFB;
        }

        .total-row {
            background-color: #FFF3E6;
            font-weight: 700;
            color: var(--primary-orange);
        }

        /* Info del cliente */
        .cliente-section {
            background-color: #E8F4FD;
            border-left: 4px solid #2DA5F3;
            border-radius: 4px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .cliente-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: #191C1F;
            margin: 0 0 12px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cliente-section i {
            color: #2DA5F3;
        }

        .cliente-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            color: #191C1F;
            font-size: 14px;
        }

        .cliente-info-item {
            display: flex;
            gap: 8px;
        }

        .cliente-info-item strong {
            color: #5F6C72;
        }
        
        @media (max-width: 768px) {
            .detalle-grid {
                grid-template-columns: 1fr;
            }
            
            .detalle-header {
                flex-direction: column;
                gap: 20px;
            }
            
            .info-row {
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .cliente-info {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-custom">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <asp:HyperLink runat="server" NavigateUrl="~/">
                            <i class="bi bi-house-door"></i> Home
                        </asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item">
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarOrdenesCompra.aspx">Gestionar Órdenes</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Detalle de la Orden</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarOrdenesCompra.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Órdenes
        </asp:HyperLink>
        
        <!-- Panel de error -->
        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="error-message">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <div>
                <strong>Error:</strong> 
                <asp:Label ID="lblMensajeError" runat="server"></asp:Label>
            </div>
        </asp:Panel>
        
        <!-- Card de detalle -->
        <asp:Panel ID="pnlDetalle" runat="server" CssClass="detalle-card">
            
            <!-- Header -->
            <div class="detalle-header">
                <div class="detalle-title">
                    <h1>Orden de Compra #<asp:Label ID="lblOrdenID" runat="server" Text=""></asp:Label></h1>
                    <span class="detalle-id">
                        Creada el: <asp:Label ID="lblFechaCreacion" runat="server" Text=""></asp:Label>
                    </span>
                </div>
                <div class="detalle-actions">
                    <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn-edit-detail" OnClick="btnEditar_Click" CausesValidation="false">
                        <i class="bi bi-pencil"></i> Editar Estado
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel-detail" OnClick="btnCancelar_Click" OnClientClick="return confirm('¿Estás seguro de cancelar esta orden?');" CausesValidation="false">
                        <i class="bi bi-x-circle"></i> Cancelar Orden
                    </asp:LinkButton>
                </div>
            </div>
            
            <!-- Información del Cliente -->
            <div class="cliente-section">
                <h3><i class="bi bi-person-circle"></i> Información del Cliente</h3>
                <div class="cliente-info">
                    <div class="cliente-info-item">
                        <strong>Nombre:</strong>
                        <span><asp:Label ID="lblClienteNombre" runat="server" Text=""></asp:Label></span>
                    </div>
                    <div class="cliente-info-item">
                        <strong>Email:</strong>
                        <span><asp:Label ID="lblClienteEmail" runat="server" Text=""></asp:Label></span>
                    </div>
                    <div class="cliente-info-item">
                        <strong>Teléfono:</strong>
                        <span><asp:Label ID="lblClienteTelefono" runat="server" Text=""></asp:Label></span>
                    </div>
                </div>
            </div>

            <!-- Vista de Detalle -->
            <asp:Panel ID="pnlVista" runat="server">
                <div class="detalle-grid">
                    
                    <!-- Columna 1 -->
                    <div class="detalle-info">
                        <div class="info-row">
                            <span class="info-label">Estado</span>
                            <div>
                                <asp:Label ID="lblEstado" runat="server" CssClass="status-badge" Text=""></asp:Label>
                            </div>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Fecha de Creación</span>
                            <span class="info-value">
                                <asp:Label ID="lblFechaCreacionDetalle" runat="server" Text=""></asp:Label>
                            </span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Fecha Límite de Pago</span>
                            <span class="info-value">
                                <asp:Label ID="lblFechaLimite" runat="server" Text=""></asp:Label>
                            </span>
                        </div>
                    </div>

                    <!-- Columna 2 -->
                    <div class="detalle-info">
                        <div class="info-row">
                            <span class="info-label">Total</span>
                            <span class="precio-value">
                                S/. <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label>
                            </span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Total con Descuento</span>
                            <span class="precio-value">
                                S/. <asp:Label ID="lblTotalDescontado" runat="server" Text="0.00"></asp:Label>
                            </span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Ahorro</span>
                            <span class="info-value" style="color: #2DB224;">
                                S/. <asp:Label ID="lblAhorro" runat="server" Text="0.00"></asp:Label>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Productos del Carrito -->
                <div class="productos-section">
                    <div class="productos-header">
                        <h3><i class="bi bi-cart-check-fill"></i> Productos de la Orden</h3>
                    </div>

                    <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="false" CssClass="productos-tabla">
                        <Columns>
                            <asp:BoundField HeaderText="PRODUCTO" DataField="nombre" />
                            <asp:BoundField HeaderText="TIPO" DataField="tipoProducto" />
                            <asp:BoundField HeaderText="PRECIO UNIT." DataField="precio" DataFormatString="S/. {0:N2}" />
                            <asp:BoundField HeaderText="CANTIDAD" DataField="cantidad" />
                            <asp:BoundField HeaderText="SUBTOTAL" DataField="subtotal" DataFormatString="S/. {0:N2}" />
                        </Columns>
                        <EmptyDataTemplate>
                            <div style="text-align: center; padding: 20px; color: #929FA5;">
                                <p>No hay productos en esta orden</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </asp:Panel>

            <!-- Formulario de Edición -->
            <asp:Panel ID="pnlFormEdicion" runat="server" Visible="false" CssClass="form-edicion">
                <h3><i class="bi bi-pencil-square"></i> Editando Orden</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Estado *</label>
                        <asp:DropDownList ID="ddlEstadoEdit" runat="server"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Fecha Límite de Pago *</label>
                        <asp:TextBox ID="txtFechaLimiteEdit" runat="server" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFechaLimite" runat="server" 
                            ControlToValidate="txtFechaLimiteEdit" 
                            ErrorMessage="Requerido" 
                            ForeColor="Red" 
                            Display="Dynamic" 
                            ValidationGroup="EditarForm" />
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="btnCancelarEdit" runat="server" Text="Cancelar" CssClass="btn-form btn-cancelar-edit" OnClick="btnCancelarEdit_Click" CausesValidation="false" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn-form btn-guardar" OnClick="btnGuardar_Click" ValidationGroup="EditarForm" />
                </div>
            </asp:Panel>
            
        </asp:Panel>
    </div>
               <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
    function mostrarModalExito() {
        // Verifica si Swal está cargado
        if (typeof Swal === 'undefined') {
            console.error('SweetAlert2 no está cargado. Revisa tu MasterPage.');
            alert('Datos guardados (Fallback)'); // Solo por si falla la librería
            return;
        }

        Swal.fire({
            title: '¡Éxito!',
            text: 'Datos cambiados con éxito',
            icon: 'success',
            confirmButtonColor: '#FA8232',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            // Opcional: Recargar la página al cerrar
            if (result.isConfirmed) {
                window.location.href = window.location.href;
            }
        });
    }

    function mostrarModalError(mensaje) {
        if (typeof Swal === 'undefined') { alert(mensaje); return; }

        Swal.fire({
            title: 'Error',
            text: mensaje,
            icon: 'error',
            confirmButtonColor: '#FA8232',
            confirmButtonText: 'Ok'
        });
    }
</script>
    
</asp:Content>