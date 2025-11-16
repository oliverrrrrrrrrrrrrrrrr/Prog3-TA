<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarLibro.aspx.cs" Inherits="CampusStoreWeb.AgregarLibro" %>
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

        /* Grid con botón */
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

        /* Sección de autores */
        .autores-section {
            background-color: #F9FAFB;
            border: 2px solid #E4E7E9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .autores-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: #191C1F;
            margin: 0 0 16px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .autores-section h3 i {
            color: var(--primary-orange);
        }

        .autores-grid {
            display: grid;
            grid-template-columns: 1fr auto auto;
            gap: 12px;
            align-items: end;
        }

        .btn-agregar-autor {
            background-color: var(--primary-orange);
            color: white;
            padding: 10px 20px;
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
        }

        .btn-agregar-autor:hover {
            background-color: #d86f28;
        }

        .autores-lista {
            grid-column: 1 / -1;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 12px;
        }

        .autor-tag {
            background-color: white;
            border: 1px solid #E4E7E9;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            color: #191C1F;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .autor-tag .btn-remove {
            background: none;
            border: none;
            color: #EE5858;
            cursor: pointer;
            font-size: 16px;
            padding: 0;
            line-height: 1;
        }

        .autor-tag .btn-remove:hover {
            color: #d63939;
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

            .autores-grid {
                grid-template-columns: 1fr;
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
                        <asp:HyperLink runat="server" NavigateUrl="~/GestionarLibros.aspx">Gestionar Libros</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Agregar Libro</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Botón volver -->
        <asp:HyperLink ID="btnVolver" runat="server" NavigateUrl="~/GestionarLibros.aspx" CssClass="btn-back">
            <i class="bi bi-arrow-left"></i> Volver a Libros
        </asp:HyperLink>
        
        <!-- Card de formulario -->
        <div class="formulario-card">
            
            <!-- Header -->
            <div class="formulario-header">
                <i class="bi bi-plus-circle-fill"></i>
                <h1>Agregar Nuevo Libro</h1>
            </div>
            
            <!-- Información -->
            <div class="info-box">
                <i class="bi bi-info-circle-fill"></i>
                <div class="info-box-content">
                    <strong>Información importante</strong>
                    <p>Complete todos los campos requeridos (*) para agregar el nuevo libro al inventario.</p>
                </div>
            </div>
            
            <!-- Formulario -->
            <div class="form-grid">
                
                <div class="form-group">
                    <label>Nombre / Título <span class="required">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Cien años de soledad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                        ControlToValidate="txtNombre" 
                        ErrorMessage="El nombre es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>ISBN <span class="required">*</span></label>
                    <asp:TextBox ID="txtISBN" runat="server" placeholder="Ej: 978-3-16-148410-0"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvISBN" runat="server" 
                        ControlToValidate="txtISBN" 
                        ErrorMessage="El ISBN es requerido" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>
                
                <div class="form-group">
                    <label>Género <span class="required">*</span></label>
                    <asp:DropDownList ID="ddlGenero" runat="server"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGenero" runat="server" 
                        ControlToValidate="ddlGenero" 
                        InitialValue="0"
                        ErrorMessage="Seleccione un género" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Formato <span class="required">*</span></label>
                    <asp:DropDownList ID="ddlFormato" runat="server"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvFormato" runat="server" 
                        ControlToValidate="ddlFormato" 
                        InitialValue="0"
                        ErrorMessage="Seleccione un formato" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Fecha de Publicación <span class="required">*</span></label>
                    <asp:TextBox ID="txtFechaPublicacion" runat="server" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaPublicacion" runat="server" 
                        ControlToValidate="txtFechaPublicacion" 
                        ErrorMessage="La fecha de publicación es requerida" 
                        CssClass="validator"
                        Display="Dynamic" 
                        ValidationGroup="AgregarForm" />
                </div>

                <div class="form-group">
                    <label>Editorial <span class="required">*</span></label>
                    <div class="form-control-with-button">
                        <asp:DropDownList ID="ddlEditorial" runat="server"></asp:DropDownList>
                        <asp:Button ID="btnNuevaEditorial" runat="server" Text="+ Nueva" CssClass="btn-nuevo-item" OnClientClick="showModalEditorial(); return false;" CausesValidation="false" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvEditorial" runat="server" 
                        ControlToValidate="ddlEditorial" 
                        InitialValue="0"
                        ErrorMessage="Seleccione una editorial" 
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

                <!-- Sección de Autores -->
                <div class="form-group form-group-full">
                    <div class="autores-section">
                        <h3><i class="bi bi-people-fill"></i> Autores</h3>
                        <div class="autores-grid">
                            <div class="form-group" style="margin-bottom: 0;">
                                <label>Seleccione un autor</label>
                                <asp:DropDownList ID="ddlAutores" runat="server"></asp:DropDownList>
                            </div>
                            <asp:Button ID="btnNuevoAutor" runat="server" Text="+ Nuevo" CssClass="btn-nuevo-item" OnClientClick="showModalAutor(); return false;" CausesValidation="false" style="margin-top: 26px;" />
                            <asp:Button ID="btnAgregarAutor" runat="server" Text="Agregar" CssClass="btn-agregar-autor" OnClick="btnAgregarAutor_Click" CausesValidation="false" style="margin-top: 26px;" />
                        </div>
                        <div class="autores-lista">
                            <asp:Repeater ID="rptAutoresSeleccionados" runat="server" OnItemCommand="rptAutoresSeleccionados_ItemCommand">
                                <ItemTemplate>
                                    <div class="autor-tag">
                                        <span><%# Eval("nombre") %></span>
                                        <asp:LinkButton runat="server" CssClass="btn-remove" CommandName="Eliminar" CommandArgument='<%# Eval("idAutor") %>' CausesValidation="false">
                                            <i class="bi bi-x"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblNoAutores" runat="server" Text="No se han agregado autores" CssClass="form-help-text" Visible="true"></asp:Label>
                        </div>
                    </div>
                </div>
                
                <div class="form-group form-group-full">
                    <label>Sinopsis</label>
                    <asp:TextBox ID="txtSinopsis" runat="server" TextMode="MultiLine" placeholder="Breve resumen del libro..."></asp:TextBox>
                    <span class="form-help-text">Opcional. Resumen breve del contenido del libro</span>
                </div>

                <div class="form-group form-group-full">
                    <label>Descripción</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" placeholder="Descripción detallada del libro..."></asp:TextBox>
                    <span class="form-help-text">Opcional. Información adicional sobre el libro</span>
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
                    Text="Guardar Libro" 
                    CssClass="btn-form btn-guardar" 
                    OnClick="btnGuardar_Click" 
                    ValidationGroup="AgregarForm">
                </asp:Button>
            </div>
            
        </div>
    </div>

    <!-- MODAL: Nueva Editorial -->
    <asp:Panel ID="pnlModalEditorial" runat="server" CssClass="modal-panel">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="bi bi-building"></i> Nueva Editorial</h2>
                <button type="button" class="btn-close-modal" onclick="hideModalEditorial()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-grid">
                    <div class="form-group form-group-full">
                        <label>Nombre <span class="required">*</span></label>
                        <asp:TextBox ID="txtEditorialNombre" runat="server" placeholder="Nombre de la editorial"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditorialNombre" runat="server" 
                            ControlToValidate="txtEditorialNombre" 
                            ErrorMessage="El nombre es requerido" 
                            CssClass="validator"
                            Display="Dynamic" 
                            ValidationGroup="EditorialForm" />
                    </div>
                    <div class="form-group">
                        <label>CIF <span class="required">*</span></label>
                        <asp:TextBox ID="txtEditorialCIF" runat="server" placeholder="CIF"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditorialCIF" runat="server" 
                            ControlToValidate="txtEditorialCIF" 
                            ErrorMessage="El CIF es requerido" 
                            CssClass="validator"
                            Display="Dynamic" 
                            ValidationGroup="EditorialForm" />
                    </div>
                    <div class="form-group">
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtEditorialTelefono" runat="server" TextMode="Number" placeholder="999999999"></asp:TextBox>
                    </div>
                    <div class="form-group form-group-full">
                        <label>Email</label>
                        <asp:TextBox ID="txtEditorialEmail" runat="server" TextMode="Email" placeholder="contacto@editorial.com"></asp:TextBox>
                    </div>
                    <div class="form-group form-group-full">
                        <label>Dirección</label>
                        <asp:TextBox ID="txtEditorialDireccion" runat="server" placeholder="Dirección completa"></asp:TextBox>
                    </div>
                    <div class="form-group form-group-full">
                        <label>Sitio Web</label>
                        <asp:TextBox ID="txtEditorialWeb" runat="server" placeholder="https://www.editorial.com"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-form btn-cancelar" onclick="hideModalEditorial()">Cancelar</button>
                <asp:Button ID="btnGuardarEditorial" runat="server" Text="Guardar Editorial" CssClass="btn-form btn-guardar" OnClick="btnGuardarEditorial_Click" ValidationGroup="EditorialForm" />
            </div>
        </div>
    </asp:Panel>

    <!-- MODAL: Nuevo Autor -->
    <asp:Panel ID="pnlModalAutor" runat="server" CssClass="modal-panel">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="bi bi-person-plus"></i> Nuevo Autor</h2>
                <button type="button" class="btn-close-modal" onclick="hideModalAutor()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Nombre <span class="required">*</span></label>
                        <asp:TextBox ID="txtAutorNombre" runat="server" placeholder="Nombre del autor"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAutorNombre" runat="server" 
                            ControlToValidate="txtAutorNombre" 
                            ErrorMessage="El nombre es requerido" 
                            CssClass="validator"
                            Display="Dynamic" 
                            ValidationGroup="AutorForm" />
                    </div>
                    <div class="form-group">
                        <label>Apellidos <span class="required">*</span></label>
                        <asp:TextBox ID="txtAutorApellidos" runat="server" placeholder="Apellidos del autor"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAutorApellidos" runat="server" 
                            ControlToValidate="txtAutorApellidos" 
                            ErrorMessage="Los apellidos son requeridos" 
                            CssClass="validator"
                            Display="Dynamic" 
                            ValidationGroup="AutorForm" />
                    </div>
                    <div class="form-group form-group-full">
                        <label>Alias / Seudónimo</label>
                        <asp:TextBox ID="txtAutorAlias" runat="server" placeholder="Alias o seudónimo (opcional)"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-form btn-cancelar" onclick="hideModalAutor()">Cancelar</button>
                <asp:Button ID="btnGuardarAutor" runat="server" Text="Guardar Autor" CssClass="btn-form btn-guardar" OnClick="btnGuardarAutor_Click" ValidationGroup="AutorForm" />
            </div>
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function showModalEditorial() {
            document.getElementById('<%= pnlModalEditorial.ClientID %>').classList.add('show');
            return false;
        }

        function hideModalEditorial() {
            document.getElementById('<%= pnlModalEditorial.ClientID %>').classList.remove('show');
            return false;
        }

        function showModalAutor() {
            document.getElementById('<%= pnlModalAutor.ClientID %>').classList.add('show');
            return false;
        }

        function hideModalAutor() {
            document.getElementById('<%= pnlModalAutor.ClientID %>').classList.remove('show');
            return false;
        }

        // Cerrar modal al hacer clic fuera del contenido
        document.addEventListener('click', function(event) {
            var modalEditorial = document.getElementById('<%= pnlModalEditorial.ClientID %>');
            var modalAutor = document.getElementById('<%= pnlModalAutor.ClientID %>');
            
            if (event.target === modalEditorial) {
                hideModalEditorial();
            }
            if (event.target === modalAutor) {
                hideModalAutor();
            }
        });
    </script>
    
</asp:Content>