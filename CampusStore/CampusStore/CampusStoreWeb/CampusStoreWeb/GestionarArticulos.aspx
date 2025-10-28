<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarArticulos.aspx.cs" Inherits="CampusStoreWeb.GestionarArticulos" %>
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
        
        /* Menú lateral */
        .sidebar-menu {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .sidebar-menu .menu-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #191C1F;
            text-decoration: none;
            border-bottom: 1px solid #E4E7E9;
            transition: all 0.3s;
            gap: 12px;
            font-size: 14px;
        }
        
        .sidebar-menu .menu-item:last-child {
            border-bottom: none;
        }
        
        .sidebar-menu .menu-item i {
            font-size: 20px;
            width: 24px;
            text-align: center;
        }
        
        .sidebar-menu .menu-item:hover {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }
        
        .sidebar-menu .menu-item.active {
            background-color: var(--primary-orange);
            color: white;
        }
        
        /* Tabla de artículos */
        .articulos-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 24px;
        }
        
        .articulos-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .articulos-header h2 {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
        }
        
        .view-all-link {
            color: var(--primary-orange);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .view-all-link:hover {
            color: #d86f28;
        }
        
        /* Tabla personalizada */
        .table-articulos {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table-articulos thead th {
            background-color: #F2F4F5;
            color: #475156;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            padding: 12px 16px;
            text-align: left;
            border-bottom: 2px solid #E4E7E9;
        }
        
        .table-articulos tbody td {
            padding: 16px;
            color: #191C1F;
            font-size: 14px;
            border-bottom: 1px solid #E4E7E9;
        }
        
        .table-articulos tbody tr:last-child td {
            border-bottom: none;
        }
        
        .table-articulos tbody tr:hover {
            background-color: #F9FAFB;
        }
        
        .articulo-id {
            color: #475156;
            font-weight: 500;
        }
        
        .articulo-stock {
            font-weight: 500;
        }
        
        .articulo-precio {
            font-weight: 600;
            color: #191C1F;
        }
        
        .btn-edit {
            background: none;
            border: none;
            color: #5F6C72;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            margin-right: 8px;
        }
        
        .btn-edit:hover {
            color: var(--primary-orange);
        }
        
        .btn-view-details {
            color: #2DA5F3;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-view-details:hover {
            color: #1e8ed9;
        }
        
        /* Botón flotante de agregar */
        .btn-add-float {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 56px;
            height: 56px;
            background-color: var(--primary-orange);
            color: white;
            border-radius: 50%;
            border: none;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(250, 130, 50, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            z-index: 1000;
        }
        
        .btn-add-float:hover {
            background-color: #d86f28;
            transform: scale(1.1);
            box-shadow: 0 6px 16px rgba(250, 130, 50, 0.5);
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
                        <asp:HyperLink runat="server" NavigateUrl="~/UserAccount.aspx">User Account</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Gestionar Artículos</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="sidebar-menu">
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarLibros.aspx" CssClass="menu-item">
                        <i class="bi bi-layers"></i>
                        <span>Gestionar Libros</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarArticulos.aspx" CssClass="menu-item active">
                        <i class="bi bi-box-seam"></i>
                        <span>Gestionar Artículos</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarEmpleados.aspx" CssClass="menu-item">
                        <i class="bi bi-person-badge"></i>
                        <span>Gestionar Empleados</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarClientes.aspx" CssClass="menu-item">
                        <i class="bi bi-cart3"></i>
                        <span>Gestionar Clientes</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarPedidos.aspx" CssClass="menu-item">
                        <i class="bi bi-file-earmark-text"></i>
                        <span>Gestionar Pedidos</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GenerarReportes.aspx" CssClass="menu-item">
                        <i class="bi bi-gear"></i>
                        <span>Generar Reportes</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/Logout.aspx" CssClass="menu-item">
                        <i class="bi bi-box-arrow-right"></i>
                        <span>Log out</span>
                    </asp:HyperLink>
                </div>
            </div>
            
            <!-- Contenido principal -->
            <div class="col-lg-9 col-md-8">
                <div class="articulos-card">
                    <!-- Header -->
                    <div class="articulos-header">
                        <h2>ARTÍCULOS</h2>
                        <asp:HyperLink runat="server" NavigateUrl="~/VerTodosArticulos.aspx" CssClass="view-all-link">
                            View All <i class="bi bi-arrow-right"></i>
                        </asp:HyperLink>
                    </div>
                    
                    <!-- Tabla -->
                    <div class="table-responsive">
                        <table class="table-articulos">
                            <thead>
                                <tr>
                                    <th>ARTÍCULO ID</th>
                                    <th>STOCK</th>
                                    <th>NOMBRE</th>
                                    <th>PRECIO UNITARIO</th>
                                    <th></th>
                                    <th>DETALLE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="articulo-id">#84562319</td>
                                    <td class="articulo-stock">12</td>
                                    <td>Mochila escolar azul</td>
                                    <td class="articulo-precio">$45.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=84562319" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#92837465</td>
                                    <td class="articulo-stock">8</td>
                                    <td>Cuaderno universitario 100 hojas</td>
                                    <td class="articulo-precio">$12.50</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=92837465" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#74829156</td>
                                    <td class="articulo-stock">25</td>
                                    <td>Peluche de Ralsei - Deltarune</td>
                                    <td class="articulo-precio">$1,500.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=74829156" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#65492837</td>
                                    <td class="articulo-stock">15</td>
                                    <td>Tomatelodo térmico 500ml</td>
                                    <td class="articulo-precio">$28.90</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=65492837" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#38291574</td>
                                    <td class="articulo-stock">30</td>
                                    <td>Set de lapiceros de colores x12</td>
                                    <td class="articulo-precio">$18.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=38291574" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#91827364</td>
                                    <td class="articulo-stock">6</td>
                                    <td>Calculadora científica Casio</td>
                                    <td class="articulo-precio">$89.90</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=91827364" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="articulo-id">#52738194</td>
                                    <td class="articulo-stock">20</td>
                                    <td>Agenda 2024 tamaño A5</td>
                                    <td class="articulo-precio">$35.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleArticulo.aspx?id=52738194" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Botón flotante para agregar nuevo artículo -->
    <asp:LinkButton ID="btnAgregarArticulo" runat="server" CssClass="btn-add-float" ToolTip="Agregar nuevo artículo">
        <i class="bi bi-plus-lg"></i>
    </asp:LinkButton>
    
</asp:Content>
