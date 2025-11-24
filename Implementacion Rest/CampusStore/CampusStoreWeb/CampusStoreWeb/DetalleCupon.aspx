<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleCupon.aspx.cs" Inherits="CampusStoreWeb.DetalleCupon" %>
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
            font-family: 'Courier New', monospace;
        }

        .detalle-id {
            color: #5F6C72;
            font-size: 14px;
        }

        .detalle-actions {
            display: flex;
            gap: 12px;
        }

        .btn-edit-detail, .btn-toggle-detail {
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

        .btn-toggle-detail {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }

        .btn-toggle-detail:hover {
            background-color: #ffe0cc;
        }

        .btn-toggle-detail.desactivar {
            background-color: #FFE5E5;
            color: #EE5858;
        }

        .btn-toggle-detail.desactivar:hover {
            background-color: #ffcccc;
        }

        /* Grid de información */
        .detalle-info {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .info-row {
            display: grid;
            grid-template-columns: 250px 1fr;
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

        .codigo-value {
            font-family: 'Courier New', monospace;
            background-color: #F2F4F5;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 600;
            color: var(--primary-orange);
            font-size: 18px;
            display: inline-block;
        }

        .descuento-value {
            color: #2DB224;
            font-size: 32px;
            font-weight: 700;
        }

        .estado-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
        }

        .estado-activo {
            background-color: #EAF7ED;
            color: #2DB224;
        }

        .estado-agotado {
            background-color: #FFE5E5;
            color: #EE5858;
        }

        .estado-vencido {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }

        .estado-inactivo {
            background-color: #E4E7E9;
            color: #5F6C72;
        }

        .usos-badge {
            background-color: #E8F4FD;
            color: #2DA5F3;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 18px;
            font-weight: 600;
            display: inline-block;
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

        /* ============================================ */
        /* FORMULARIO DE EDICIÓN INLINE */
        /* ============================================ */
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
        .form-group select,
        .form-group textarea {
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
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-orange);
        }

        .form-group input:disabled {
            background-color: #F2F4F5;
            cursor: not-allowed;
        }

        .form-help-text {
            font-size: 12px;
            color: #5F6C72;
            margin-top: 4px;
            display: block;
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

        @media (max-width: 768px) {
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarCupones.aspx">Gestionar Cupones</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Detalle del Cupón</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container">

        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarCupones.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Cupones
        </asp:HyperLink>

        <!-- Panel de error (oculto por defecto) -->
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
                    <h1>
                        <asp:Label ID="lblCodigoCupon" runat="server" Text=""></asp:Label>
                    </h1>
                    <span class="detalle-id">
                        Cupón ID: #<asp:Label ID="lblCuponID" runat="server" Text=""></asp:Label>
                    </span>
                </div>
                <div class="detalle-actions">
                    <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn-edit-detail" OnClick="btnEditar_Click" CausesValidation="false">
                        <i class="bi bi-pencil"></i> Editar
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCambiarEstado" runat="server" CssClass="btn-toggle-detail" OnClick="btnCambiarEstado_Click" OnClientClick="return confirm('¿Estás seguro de cambiar el estado de este cupón?');" CausesValidation="false">
                        <i class="bi bi-toggle-on"></i> <asp:Label ID="lblTextoBoton" runat="server" Text="Desactivar"></asp:Label>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Vista de Detalle (solo lectura) -->
            <asp:Panel ID="pnlVista" runat="server">
                <div class="detalle-info">

                    <div class="info-row">
                        <span class="info-label">Código del Cupón</span>
                        <div>
                            <span class="codigo-value">
                                <asp:Label ID="lblCodigo" runat="server" Text=""></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Descuento</span>
                        <div>
                            <span class="descuento-value">
                                <asp:Label ID="lblDescuento" runat="server" Text=""></asp:Label>% OFF
                            </span>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Fecha de Caducidad</span>
                        <span class="info-value">
                            <asp:Label ID="lblFechaCaducidad" runat="server" Text=""></asp:Label>
                        </span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Usos Restantes</span>
                        <div>
                            <span class="usos-badge">
                                <asp:Label ID="lblUsosRestantes" runat="server" Text=""></asp:Label> usos disponibles
                            </span>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Estado</span>
                        <div>
                            <asp:Label ID="lblEstado" runat="server" CssClass="estado-badge" Text=""></asp:Label>
                        </div>
                    </div>

                </div>
            </asp:Panel>

            <!-- Formulario de Edición del Cupón -->
            <asp:Panel ID="pnlFormEdicion" runat="server" Visible="false" CssClass="form-edicion">
                <h3><i class="bi bi-pencil-square"></i> Editando cupón</h3>
                <div class="form-grid">
                    
                    <div class="form-group">
                        <label>Código del Cupón</label>
                        <asp:TextBox ID="txtCodigo" runat="server" Enabled="false"></asp:TextBox>
                        <span class="form-help-text">El código no se puede modificar una vez creado</span>
                    </div>

                    <div class="form-group">
                        <label>Descuento (%) *</label>
                        <asp:TextBox ID="txtDescuento" runat="server" TextMode="Number" step="0.01" min="1" max="100"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescuento" runat="server" 
                            ControlToValidate="txtDescuento" 
                            ErrorMessage="El descuento es requerido" 
                            ForeColor="Red" 
                            Display="Dynamic" 
                            ValidationGroup="EditarForm" />
                        <asp:RangeValidator ID="rvDescuento" runat="server" 
                            ControlToValidate="txtDescuento"
                            MinimumValue="1"
                            MaximumValue="100"
                            Type="Double"
                            ErrorMessage="El descuento debe estar entre 1% y 100%"
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="EditarForm" />
                    </div>

                    <div class="form-group">
                        <label>Fecha de Caducidad *</label>
                        <asp:TextBox ID="txtFechaCaducidad" runat="server" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFechaCaducidad" runat="server" 
                            ControlToValidate="txtFechaCaducidad" 
                            ErrorMessage="La fecha es requerida" 
                            ForeColor="Red" 
                            Display="Dynamic" 
                            ValidationGroup="EditarForm" />
                    </div>

                    <div class="form-group">
                        <label>Usos Disponibles *</label>
                        <asp:TextBox ID="txtUsosRestantes" runat="server" TextMode="Number" min="0"></asp:TextBox>
                        <span class="form-help-text">Puede agregar más usos si lo desea</span>
                        <asp:RequiredFieldValidator ID="rfvUsosRestantes" runat="server" 
                            ControlToValidate="txtUsosRestantes" 
                            ErrorMessage="Los usos son requeridos" 
                            ForeColor="Red" 
                            Display="Dynamic" 
                            ValidationGroup="EditarForm" />
                        <asp:RangeValidator ID="rvUsosRestantes" runat="server" 
                            ControlToValidate="txtUsosRestantes"
                            MinimumValue="0"
                            MaximumValue="999999"
                            Type="Integer"
                            ErrorMessage="Ingrese un número válido"
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