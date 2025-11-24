<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarEmpleado.aspx.cs" Inherits="CampusStoreWeb.AgregarEmpleado" %>
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
        .formulario-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        
        .formulario-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #E4E7E9;
        }
        
        .formulario-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
        }
        
        .formulario-header i {
            color: var(--primary-orange);
            font-size: 32px;
        }
        
        /* Grid de formulario */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 24px;
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
        
        .form-group label .required {
            color: #EE5858;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
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
            box-shadow: 0 0 0 3px rgba(250, 130, 50, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-group .validator {
            color: #EE5858;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }
        
        .form-help-text {
            font-size: 12px;
            color: #5F6C72;
            margin-top: 4px;
        }
        
        /* Acciones del formulario */
        .form-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #E4E7E9;
        }
        
        .btn-form {
            padding: 14px 32px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-guardar {
            background-color: var(--primary-orange);
            color: white;
        }
        
        .btn-guardar:hover {
            background-color: #d86f28;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(250, 130, 50, 0.3);
        }
        
        .btn-cancelar {
            background-color: #E4E7E9;
            color: #5F6C72;
        }
        
        .btn-cancelar:hover {
            background-color: #d1d5d9;
        }
        
        /* Mensaje de información */
        .info-box {
            background-color: #E8F4FD;
            border-left: 4px solid #2DA5F3;
            padding: 16px;
            border-radius: 4px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .info-box i {
            color: #2DA5F3;
            font-size: 20px;
            margin-top: 2px;
        }
        
        .info-box-content {
            flex: 1;
        }
        
        .info-box-content strong {
            display: block;
            color: #191C1F;
            margin-bottom: 4px;
        }
        
        .info-box-content p {
            color: #5F6C72;
            font-size: 14px;
            margin: 0;
        }

        /* Grid con botón para rol */
        .form-control-with-button {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 8px;
            align-items: start;
        }

        .btn-nuevo-item {
            background-color: #2DA5F3;
            color: white;
            padding: 10px 16px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s;
            white-space: nowrap;
            margin-top: 26px;
        }

        .btn-nuevo-item:hover {
            background-color: #1e8ed9;
        }

        /* Panel Modal */
        .modal-panel {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            padding: 20px;
        }

        .modal-panel.show {
            display: flex;
        }

        .modal-content {
            background-color: white;
            border-radius: 8px;
            max-width: 600px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            padding: 24px;
            border-bottom: 2px solid #E4E7E9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-header h2 i {
            color: var(--primary-orange);
        }

        .btn-close-modal {
            background: none;
            border: none;
            color: #5F6C72;
            font-size: 24px;
            cursor: pointer;
            padding: 0;
            line-height: 1;
        }

        .btn-close-modal:hover {
            color: var(--primary-orange);
        }

        .modal-body {
            padding: 24px;
        }

        .modal-footer {
            padding: 20px 24px;
            border-top: 1px solid #E4E7E9;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .formulario-card {
                padding: 24px;
            }
            
            .form-actions {
                flex-direction: column-reverse;
            }
            
            .btn-form {
                width: 100%;
                justify-content: center;
            }

            .form-control-with-button {
                grid-template-columns: 1fr;
            }

            .btn-nuevo-item {
                margin-top: 8px;
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarEmpleados.aspx">Gestionar Empleados</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Agregar Empleado</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarEmpleados.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Empleados
        </asp:HyperLink>
        
        <!-- Card de formulario -->
        <div class="formulario-card">
            
            <!-- Header -->
            <div class="formulario-header">
                <i class="bi bi-person-plus-fill"></i>
                <h1>Agregar Nuevo Empleado</h1>
            </div>
            
            <!-- Información -->
            <div class="info-box">
                <i class="bi bi-info-circle-fill"></i>
                <div class="info-box-content">
                    <strong>Información importante</strong>
                    <p>Complete todos los campos requeridos (*) para agregar el nuevo empleado al sistema.</p>
                </div>
            </div>
            
            <!-- Formulario -->
            <div class="form-grid">
                
                <div class="form-group">
                    <label>Nombre Completo <span class="required">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Juan Pérez García"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                        ControlToValidate="txtNombre" 
                        ErrorMessage="El nombre es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Nombre de Usuario <span class="required">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Ej: jperez"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                        ControlToValidate="txtUsername" 
                        ErrorMessage="El nombre de usuario es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Contraseña <span class="required">*</span></label>
                    <asp:TextBox ID="txtContraseña" runat="server" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvContraseña" runat="server" 
                        ControlToValidate="txtContraseña" 
                        ErrorMessage="La contraseña es requerida" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Correo Electrónico <span class="required">*</span></label>
                    <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" placeholder="Ej: jperez@campusstore.com"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" 
                        ControlToValidate="txtCorreo" 
                        ErrorMessage="El correo es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RegularExpressionValidator ID="revCorreo" runat="server" 
                        ControlToValidate="txtCorreo"
                        ErrorMessage="Ingrese un correo válido"
                        ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Teléfono <span class="required">*</span></label>
                    <asp:TextBox ID="txtTelefono" runat="server" placeholder="Ej: 999999999" MaxLength="9"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" 
                        ControlToValidate="txtTelefono" 
                        ErrorMessage="El teléfono es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" 
                        ControlToValidate="txtTelefono"
                        ErrorMessage="Ingrese un teléfono válido (9 dígitos)"
                        ValidationExpression="^9\d{8}$"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Sueldo (S/.) <span class="required">*</span></label>
                    <asp:TextBox ID="txtSueldo" runat="server" TextMode="Number" step="0.01" min="0" placeholder="0.00"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSueldo" runat="server" 
                        ControlToValidate="txtSueldo" 
                        ErrorMessage="El sueldo es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvSueldo" runat="server" 
                        ControlToValidate="txtSueldo"
                        MinimumValue="0.01"
                        MaximumValue="999999"
                        Type="Double"
                        ErrorMessage="Ingrese un sueldo válido mayor a 0"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Rol <span class="required">*</span></label>
                    <div class="form-control-with-button">
                        <asp:DropDownList ID="ddlRol" runat="server"></asp:DropDownList>
                        <asp:Button ID="btnNuevoRol" runat="server" Text="+ Nuevo" CssClass="btn-nuevo-item" OnClientClick="showModalRol(); return false;" CausesValidation="false" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvRol" runat="server" 
                        ControlToValidate="ddlRol" 
                        InitialValue="0"
                        ErrorMessage="Seleccione un rol" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Estado</label>
                    <asp:CheckBox ID="chkActivo" runat="server" Text="Empleado Activo" Checked="true" />
                    <span class="form-help-text">Marque si el empleado estará activo desde el inicio</span>
                </div>
                
            </div>
            
            <!-- Botones de acción -->
            <div class="form-actions">
                <asp:Button ID="btnCancelar" runat="server" 
                    Text="Cancelar" 
                    CssClass="btn-form btn-cancelar" 
                    OnClick="btnCancelar_Click" 
                    CausesValidation="false" />
                <asp:Button ID="btnGuardar" runat="server" 
                    Text="Guardar Empleado" 
                    CssClass="btn-form btn-guardar" 
                    OnClick="btnGuardar_Click" 
                    ValidationGroup="AgregarForm">
                </asp:Button>
            </div>
            
        </div>
    </div>

    <!-- MODAL: Nuevo Rol -->
    <asp:Panel ID="pnlModalRol" runat="server" CssClass="modal-panel">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="bi bi-shield-check"></i> Nuevo Rol</h2>
                <button type="button" class="btn-close-modal" onclick="hideModalRol()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-grid">
                    <div class="form-group form-group-full">
                        <label>Nombre <span class="required">*</span></label>
                        <asp:TextBox ID="txtRolNombre" runat="server" placeholder="Nombre del rol"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRolNombre" runat="server" 
                            ControlToValidate="txtRolNombre" 
                            ErrorMessage="El nombre es requerido" 
                            CssClass="validator"
                            Display="Dynamic" 
                            ValidationGroup="RolForm" />
                    </div>
                    <div class="form-group form-group-full">
                        <label>Descripción</label>
                        <asp:TextBox ID="txtRolDescripcion" runat="server" TextMode="MultiLine" placeholder="Descripción del rol (opcional)"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-form btn-cancelar" onclick="hideModalRol()">Cancelar</button>
                <asp:Button ID="btnGuardarRol" runat="server" Text="Guardar Rol" CssClass="btn-form btn-guardar" OnClick="btnGuardarRol_Click" ValidationGroup="RolForm" />
            </div>
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function showModalRol() {
            document.getElementById('<%= pnlModalRol.ClientID %>').classList.add('show');
            return false;
        }

        function hideModalRol() {
            document.getElementById('<%= pnlModalRol.ClientID %>').classList.remove('show');
            return false;
        }

        // Cerrar modal al hacer clic fuera del contenido
        document.addEventListener('click', function(event) {
            var modalRol = document.getElementById('<%= pnlModalRol.ClientID %>');
            
            if (event.target === modalRol) {
                hideModalRol();
            }
        });
    </script>
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
            text: 'Empleado agregado con exito :D',
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
    function mostrarModalExitoRol() {
        // Verifica si Swal está cargado
        if (typeof Swal === 'undefined') {
            console.error('SweetAlert2 no está cargado. Revisa tu MasterPage.');
            alert('Datos guardados (Fallback)'); // Solo por si falla la librería
            return;
        }

        Swal.fire({
            title: '¡Éxito!',
            text: 'Rol modificado con exito :D',
            icon: 'success',
            confirmButtonColor: '#FA8232',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            // Opcional: Recargar la página al cerrar
            if (result.isConfirmed) {
                window.location.href = "GestionarEmpleados.aspx";;
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