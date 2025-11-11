<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleCliente.aspx.cs" Inherits="CampusStoreWeb.DetalleCliente" %>
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

    .btn-edit-detail, .btn-delete-detail {
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

    .btn-delete-detail {
        background-color: #FFE5E5;
        color: #EE5858;
    }

    .btn-delete-detail:hover {
        background-color: #ffcccc;
    }

    /* Grid de información */
    .detalle-grid {
        display: grid;
        grid-template-columns: 300px 1fr;
        gap: 40px;
        margin-bottom: 40px;
    }

    .detalle-imagen {
        width: 100%;
        aspect-ratio: 1;
        border: 2px solid #E4E7E9;
        border-radius: 8px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #F9FAFB;
    }

    .detalle-imagen img {
        width: 100%;
        height: 100%;
        object-fit: cover;
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

    .stock-badge {
        display: inline-block;
        padding: 6px 16px;
        border-radius: 4px;
        font-size: 14px;
        font-weight: 600;
    }

    .stock-disponible {
        background-color: #EAF7ED;
        color: #2DB224;
    }

    .stock-bajo {
        background-color: #FFF3E6;
        color: var(--primary-orange);
    }

    .stock-agotado {
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

    .form-group textarea {
        resize: vertical;
        min-height: 80px;
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

    /* ============================================ */
    /* SECCIÓN DE DESCUENTO */
    /* ============================================ */
    .descuento-section {
        background-color: #F9FAFB;
        border: 2px solid #E4E7E9;
        border-radius: 8px;
        padding: 24px;
        margin-top: 30px;
    }

    .descuento-header {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
    }

    .descuento-header h3 {
        font-size: 18px;
        font-weight: 600;
        color: #191C1F;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .descuento-header i {
        color: var(--primary-orange);
        font-size: 22px;
    }

    .descuento-activo {
        background-color: white;
        border: 2px solid #2DB224;
        border-radius: 8px;
        padding: 20px;
    }

    .descuento-activo-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background-color: #EAF7ED;
        color: #2DB224;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 16px;
    }

    .descuento-info-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;
        margin-bottom: 16px;
    }

    .descuento-info-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .descuento-info-label {
        font-size: 12px;
        color: #5F6C72;
        text-transform: uppercase;
        font-weight: 600;
    }

    .descuento-info-value {
        font-size: 16px;
        color: #191C1F;
        font-weight: 600;
    }

    .descuento-valor-grande {
        font-size: 24px;
        color: #2DB224;
    }

    .descuento-actions {
        display: flex;
        gap: 10px;
        padding-top: 16px;
        border-top: 1px solid #E4E7E9;
    }

    .sin-descuento {
        background-color: white;
        border: 2px dashed #E4E7E9;
        border-radius: 8px;
        padding: 30px;
        text-align: center;
    }

    .sin-descuento i {
        font-size: 48px;
        color: #929FA5;
        margin-bottom: 12px;
    }

    .sin-descuento p {
        color: #5F6C72;
        margin-bottom: 16px;
    }

    .btn-agregar-descuento {
        background-color: var(--primary-orange);
        color: white;
        padding: 10px 24px;
        border-radius: 4px;
        font-size: 14px;
        font-weight: 600;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;
    }

    .btn-agregar-descuento:hover {
        background-color: #d86f28;
    }

    .btn-small {
        padding: 8px 16px;
        font-size: 13px;
    }

    .btn-secondary-small {
        background-color: #E4E7E9;
        color: #5F6C72;
    }

    .btn-secondary-small:hover {
        background-color: #d1d5d9;
    }

    .btn-danger-small {
        background-color: #FFE5E5;
        color: #EE5858;
    }

    .btn-danger-small:hover {
        background-color: #ffcccc;
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

        .descuento-info-grid {
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarClientes.aspx">Gestionar Clientes</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Detalle del Cliente</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container">

        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarClientes.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Clientes
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
                        <asp:Label ID="lblNombreCliente" runat="server" Text=""></asp:Label>
                    </h1>
                    <span class="detalle-id">
                        Cliente ID: #<asp:Label ID="lblClienteID" runat="server" Text=""></asp:Label>
                    </span>
                </div>
                <div class="detalle-actions">
                    <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn-edit-detail" OnClick="btnEditar_Click" CausesValidation="false">
                        <i class="bi bi-pencil"></i> Editar
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnEliminar" runat="server" CssClass="btn-delete-detail" OnClick="btnEliminar_Click" OnClientClick="return confirm('¿Estás seguro de eliminar este artículo?');" CausesValidation="false">
                        <i class="bi bi-trash"></i> Eliminar
                    </asp:LinkButton>
                </div>
            </div>
    
            <!-- Vista de Detalle (solo lectura) -->
            <asp:Panel ID="pnlVista" runat="server">
                <div class="detalle-grid">
            
                    <!-- Información -->
                    <div class="detalle-info">

                        <div class ="info-row">
                            <span class="info-label">Nombre</span>
                            <div>
                                <asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label>
                            </div>
                        </div>

                        <div class ="info-row">
                            <span class="info-label">Username</span>
                            <div>
                                <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                            </div>
                        </div>

                        <div class ="info-row">
                            <span class="info-label">Contraseña</span>
                            <div>
                                <asp:Label ID="lblContraseña" runat="server" Text="Contraseña"></asp:Label>
                            </div>
                        </div>

                        <div class ="info-row">
                            <span class="info-label">Correo</span>
                            <div>
                                <asp:Label ID="lblCorreo" runat="server" Text="Correo"></asp:Label>
                            </div>
                        </div>

                        <div class ="info-row">
                            <span class="info-label">Teléfono</span>
                            <div>
                                <asp:Label ID="lblTelefono" runat="server" Text="Teléfono"></asp:Label>
                            </div>
                        </div>
                
                        <!-- falta cupones?, puede ser en un "Ver cupones" pantalla aparte, ya que puede cargar demasiado -->
                
                    </div>
                </div>
            </asp:Panel>



            <!-- Formulario de Edición del Cliente -->
            <asp:Panel ID="pnlFormEdicion" runat="server" Visible="false" CssClass="form-edicion">
                <h3><i class="bi bi-pencil-square"></i> Editando artículo</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Nombre *</label>
                        <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="EditarForm" />
                    </div>
                    <div class="form-group">
                        <label>Username *</label>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="EditarForm" />
                    </div>
                    <div class="form-group">
                        <label>Contraseña *</label>
                        <asp:TextBox ID="txtContraseña" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtContraseña" ErrorMessage="Requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="EditarForm" />
                    </div>
                    <div class="form-group">
                        <label>Correo *</label>
                        <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCorreo" ErrorMessage="Requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="EditarForm" />
                    </div>
                    <div class="form-group">
                        <label>Teléfono *</label>
                        <asp:TextBox ID="txtTelefono" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="EditarForm" />
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="btnCancelarEdit" runat="server" Text="Cancelar" CssClass="btn-form btn-cancelar-edit" OnClick="btnCancelarEdit_Click" CausesValidation="false" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn-form btn-guardar" OnClick="btnGuardar_Click" ValidationGroup="EditarForm" />
                </div>
            </asp:Panel>
    
        </asp:Panel>
    </div>
</asp:Content>
