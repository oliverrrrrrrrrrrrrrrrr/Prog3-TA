<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarArticulo.aspx.cs" Inherits="CampusStoreWeb.AgregarArticulo" %>
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
            min-height: 120px;
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarArticulos.aspx">Gestionar Artículos</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Agregar Artículo</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarArticulos.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Artículos
        </asp:HyperLink>
        
        <!-- Card de formulario -->
        <div class="formulario-card">
            
            <!-- Header -->
            <div class="formulario-header">
                <i class="bi bi-plus-circle-fill"></i>
                <h1>Agregar Nuevo Artículo</h1>
            </div>
            
            <!-- Información -->
            <div class="info-box">
                <i class="bi bi-info-circle-fill"></i>
                <div class="info-box-content">
                    <strong>Información importante</strong>
                    <p>Complete todos los campos requeridos (*) para agregar el nuevo artículo al inventario.</p>
                </div>
            </div>
            
            <!-- Formulario -->
            <div class="form-grid">
                
                <div class="form-group">
                    <label>Nombre <span class="required">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Cuaderno universitario"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                        ControlToValidate="txtNombre" 
                        ErrorMessage="El nombre es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Categoría <span class="required">*</span></label>
                    <asp:DropDownList ID="ddlCategoria" runat="server"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCategoria" runat="server" 
                        ControlToValidate="ddlCategoria" 
                        InitialValue="0"
                        ErrorMessage="Seleccione una categoría" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Precio Unitario (S/.) <span class="required">*</span></label>
                    <asp:TextBox ID="txtPrecioUnitario" runat="server" TextMode="Number" step="0.01" min="0" placeholder="0.00"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrecioUnitario" runat="server" 
                        ControlToValidate="txtPrecioUnitario" 
                        ErrorMessage="El precio es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvPrecioUnitario" runat="server" 
                        ControlToValidate="txtPrecioUnitario"
                        MinimumValue="0.01"
                        MaximumValue="999999"
                        Type="Double"
                        ErrorMessage="Ingrese un precio válido mayor a 0"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Precio con Descuento (S/.)</label>
                    <asp:TextBox ID="txtPrecioConDescuento" runat="server" TextMode="Number" step="0.01" min="0" placeholder="0.00"></asp:TextBox>
                    <span class="form-help-text">Dejar en 0.00 si no aplica descuento inicial</span>
                    <asp:RangeValidator ID="rvPrecioConDescuento" runat="server" 
                        ControlToValidate="txtPrecioConDescuento"
                        MinimumValue="0"
                        MaximumValue="999999"
                        Type="Double"
                        ErrorMessage="Ingrese un precio válido"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Stock Real <span class="required">*</span></label>
                    <asp:TextBox ID="txtStockReal" runat="server" TextMode="Number" min="0" placeholder="0"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStockReal" runat="server" 
                        ControlToValidate="txtStockReal" 
                        ErrorMessage="El stock real es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvStockReal" runat="server" 
                        ControlToValidate="txtStockReal"
                        MinimumValue="0"
                        MaximumValue="999999"
                        Type="Integer"
                        ErrorMessage="Ingrese un stock válido"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Stock Virtual <span class="required">*</span></label>
                    <asp:TextBox ID="txtStockVirtual" runat="server" TextMode="Number" min="0" placeholder="0"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStockVirtual" runat="server" 
                        ControlToValidate="txtStockVirtual" 
                        ErrorMessage="El stock virtual es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvStockVirtual" runat="server" 
                        ControlToValidate="txtStockVirtual"
                        MinimumValue="0"
                        MaximumValue="999999"
                        Type="Integer"
                        ErrorMessage="Ingrese un stock válido"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <!-- Sección de Imagen -->
                <div class="form-group form-group-full">
                    <label>Portada (imagen) <span class="required">*</span></label>
                    <asp:FileUpload ID="fuPortada" runat="server" />
                    <span class="form-help-text">
                        Seleccione una imagen desde su computadora (JPG, PNG).
                    </span>
                </div>
                
                <div class="form-group form-group-full">
                    <label>Descripción</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" placeholder="Descripción detallada del artículo..."></asp:TextBox>
                    <span class="form-help-text">Opcional. Agregue información adicional sobre el artículo</span>
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
                    Text="Guardar Artículo" 
                    CssClass="btn-form btn-guardar" 
                    OnClick="btnGuardar_Click" 
                    ValidationGroup="AgregarForm">
                </asp:Button>
            </div>
            
        </div>
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
            text: 'Articulo agregado con exito :D',
            icon: 'success',
            confirmButtonColor: '#FA8232',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            // Opcional: Recargar la página al cerrar
            if (result.isConfirmed) {
                window.location.href = "GestionarArticulos.aspx";;
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
