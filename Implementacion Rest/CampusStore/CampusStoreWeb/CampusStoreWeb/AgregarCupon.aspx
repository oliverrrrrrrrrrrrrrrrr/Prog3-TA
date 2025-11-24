<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarCupon.aspx.cs" Inherits="CampusStoreWeb.AgregarCupon" %>
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
            display: block;
        }

        .codigo-preview {
            font-family: 'Courier New', monospace;
            background-color: #F2F4F5;
            padding: 12px 16px;
            border-radius: 4px;
            font-weight: 600;
            color: var(--primary-orange);
            font-size: 16px;
            text-align: center;
            margin-top: 8px;
            border: 2px dashed #E4E7E9;
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

        .warning-box {
            background-color: #FFF3E6;
            border-left: 4px solid var(--primary-orange);
            padding: 16px;
            border-radius: 4px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .warning-box i {
            color: var(--primary-orange);
            font-size: 20px;
            margin-top: 2px;
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarCupones.aspx">Gestionar Cupones</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Agregar Cupón</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarCupones.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Cupones
        </asp:HyperLink>
        
        <!-- Card de formulario -->
        <div class="formulario-card">
            
            <!-- Header -->
            <div class="formulario-header">
                <i class="bi bi-ticket-perforated-fill"></i>
                <h1>Agregar Nuevo Cupón</h1>
            </div>
            
            <!-- Información -->
            <div class="info-box">
                <i class="bi bi-info-circle-fill"></i>
                <div class="info-box-content">
                    <strong>Información importante</strong>
                    <p>Complete todos los campos requeridos (*) para crear un nuevo cupón de descuento. Los clientes podrán usar este código al momento de realizar sus compras.</p>
                </div>
            </div>

            <!-- Advertencia -->
            <div class="warning-box">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <div class="info-box-content">
                    <strong>Importante</strong>
                    <p>El código del cupón NO podrá ser modificado después de crearlo. Asegúrese de escribirlo correctamente.</p>
                </div>
            </div>
            
            <!-- Formulario -->
            <div class="form-grid">
                
                <div class="form-group">
                    <label>Código del Cupón <span class="required">*</span></label>
                    <asp:TextBox ID="txtCodigo" runat="server" placeholder="Ej: VERANO2025" MaxLength="20" style="text-transform: uppercase;"></asp:TextBox>
                    <span class="form-help-text">Solo letras mayúsculas y números, sin espacios</span>
                    <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" 
                        ControlToValidate="txtCodigo" 
                        ErrorMessage="El código es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RegularExpressionValidator ID="revCodigo" runat="server" 
                        ControlToValidate="txtCodigo"
                        ErrorMessage="Solo letras mayúsculas y números (sin espacios ni caracteres especiales)"
                        ValidationExpression="^[A-Z0-9]+$"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Descuento (%) <span class="required">*</span></label>
                    <asp:TextBox ID="txtDescuento" runat="server" TextMode="Number" step="0.01" min="1" max="100" placeholder="Ej: 20"></asp:TextBox>
                    <span class="form-help-text">Entre 1% y 100% de descuento</span>
                    <asp:RequiredFieldValidator ID="rfvDescuento" runat="server" 
                        ControlToValidate="txtDescuento" 
                        ErrorMessage="El descuento es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvDescuento" runat="server" 
                        ControlToValidate="txtDescuento"
                        MinimumValue="1"
                        MaximumValue="100"
                        Type="Double"
                        ErrorMessage="El descuento debe estar entre 1% y 100%"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Fecha de Caducidad <span class="required">*</span></label>
                    <asp:TextBox ID="txtFechaCaducidad" runat="server" TextMode="Date"></asp:TextBox>
                    <span class="form-help-text">Fecha hasta la cual el cupón será válido</span>
                    <asp:RequiredFieldValidator ID="rfvFechaCaducidad" runat="server" 
                        ControlToValidate="txtFechaCaducidad" 
                        ErrorMessage="La fecha de caducidad es requerida" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:CompareValidator ID="cvFechaCaducidad" runat="server"
                        ControlToValidate="txtFechaCaducidad"
                        Type="Date"
                        Operator="GreaterThanEqual"
                        ErrorMessage="La fecha no puede ser anterior a hoy"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Usos Disponibles <span class="required">*</span></label>
                    <asp:TextBox ID="txtUsosDisponibles" runat="server" TextMode="Number" min="1" placeholder="Ej: 100"></asp:TextBox>
                    <span class="form-help-text">Número de veces que el cupón puede ser utilizado</span>
                    <asp:RequiredFieldValidator ID="rfvUsosDisponibles" runat="server" 
                        ControlToValidate="txtUsosDisponibles" 
                        ErrorMessage="Los usos disponibles son requeridos" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                    <asp:RangeValidator ID="rvUsosDisponibles" runat="server" 
                        ControlToValidate="txtUsosDisponibles"
                        MinimumValue="1"
                        MaximumValue="999999"
                        Type="Integer"
                        ErrorMessage="Debe ser al menos 1 uso"
                        CssClass="validator"
                        Display="Dynamic"
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group form-group-full">
                    <label>Estado Inicial</label>
                    <asp:CheckBox ID="chkActivo" runat="server" Text="Cupón activo desde el momento de creación" Checked="true" />
                    <span class="form-help-text">Si desmarca esta opción, el cupón se creará inactivo y deberá activarlo manualmente después</span>
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
                    Text="Guardar Cupón" 
                    CssClass="btn-form btn-guardar" 
                    OnClick="btnGuardar_Click" 
                    ValidationGroup="AgregarForm">
                </asp:Button>
            </div>
            
        </div>
    </div>
    
</asp:Content>